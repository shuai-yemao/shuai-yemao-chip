#!/usr/bin/env node
// 切换 Claude Code API 环境: DeepSeek ↔ MIMO
// Usage: node switch-env.js [deepseek|mimo]
//
// v2: 添加快照保护 — 检测当前状态，防止同方向连跑两次销毁反向快照

const fs = require('fs');
const path = require('path');

const settingsPath = path.join(process.env.HOME || process.env.USERPROFILE, '.claude', 'settings.json');

let settings;
try {
  settings = JSON.parse(fs.readFileSync(settingsPath, 'utf8'));
} catch (e) {
  console.error(`[!] 无法读取 settings.json: ${e.message}`);
  process.exit(1);
}

const target = (process.argv[2] || '').toLowerCase();
const force = process.argv.includes('--force') || process.argv.includes('-f');

// 检测当前使用的 API
function detectCurrent(settings) {
  const url = (settings.env && settings.env.ANTHROPIC_BASE_URL) || '';
  if (url.includes('xiaomimimo')) return 'mimo';
  if (url.includes('deepseek')) return 'deepseek';
  return 'unknown';
}

const current = detectCurrent(settings);

// ---- 无参数 → 显示当前状态
if (!target) {
  console.log('用法: node switch-env.js [deepseek|mimo]');
  console.log('');
  console.log('当前配置:');
  console.log(`  检测到:   ${current}`);
  console.log(`  BASE_URL: ${(settings.env && settings.env.ANTHROPIC_BASE_URL) || '未设置'}`);
  console.log(`  MODEL:    ${(settings.env && settings.env.ANTHROPIC_MODEL) || '未设置'}`);
  console.log(`  Token:    ${((settings.env && settings.env.ANTHROPIC_AUTH_TOKEN) || '').slice(0, 14)}...`);
  process.exit(0);
}

// ---- 防止同方向重复执行
if (target === current && !force) {
  console.log(`[!] 当前已经是 ${target} 配置，无需切换`);
  console.log('    使用 --force 强制重新保存快照');
  process.exit(0);
}

// ---- 切换逻辑
if (target === 'mimo') {
  if (!settings._mimo_env) {
    console.error('[!] 未找到 _mimo_env 配置');
    process.exit(1);
  }

  // 只在当前非 mimo 时保存 DeepSeek 快照
  if (current !== 'mimo') {
    settings._deepseek_env = {};
    for (const key of Object.keys(settings._mimo_env)) {
      if (key in (settings.env || {})) {
        settings._deepseek_env[key] = settings.env[key];
      }
    }
    console.log('[OK] DeepSeek 快照已保存到 _deepseek_env');
  }

  // 应用 MIMO 配置
  for (const [key, val] of Object.entries(settings._mimo_env)) {
    settings.env[key] = val;
  }
  console.log('[OK] 已切换到 MIMO API (mimo-v2.5)');
} else if (target === 'deepseek') {
  if (!settings._deepseek_env) {
    console.error('[!] 未找到 _deepseek_env 快照（之前未保存过 DeepSeek 快照）');
    console.error('    从 _mimo_env 中还原重叠的 key...');

    // 从已知的默认值尝试恢复
    const deepseekDefaults = {
      ANTHROPIC_AUTH_TOKEN: 'sk-a8f62be7d62d453d9bb323bf649916cb',
      ANTHROPIC_BASE_URL: 'https://api.deepseek.com/anthropic',
      ANTHROPIC_MODEL: 'deepseek-v4-pro',
      ANTHROPIC_DEFAULT_HAIKU_MODEL: 'deepseek-v4-flash',
      ANTHROPIC_DEFAULT_SONNET_MODEL: 'deepseek-v4-pro',
      ANTHROPIC_DEFAULT_OPUS_MODEL: 'deepseek-v4-pro',
      CLAUDE_CODE_SUBAGENT_MODEL: 'deepseek-v4-flash',
    };

    console.log('[?] 使用内置 DeepSeek 默认值恢复');
    for (const [key, val] of Object.entries(deepseekDefaults)) {
      settings.env[key] = val;
    }
    // 保留非模型特定的键
    const keepKeys = ['ALL_PROXY', 'CLAUDE_CODE_MAX_OUTPUT_TOKENS', 'MAX_THINKING_TOKENS',
                       'CLAUDE_CODE_SKIP_FAST_MODE_NETWORK_ERRORS', 'CLAUDE_CODE_SKIP_UPDATE_CHECK',
                       'CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS', 'CLAUDE_CODE_EFFORT_LEVEL',
                       'EDITOR', 'LANG', 'LC_ALL', 'SHELL', 'PYTHONIOENCODING',
                       'DISABLE_NON_ESSENTIAL_MODEL_CALLS', 'CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC'];
    for (const key of keepKeys) {
      if (settings._mimo_env && key in settings._mimo_env) {
        settings.env[key] = settings._mimo_env[key];
      }
    }
  } else {
    // 只在当前非 deepseek 时还原
    if (current !== 'deepseek') {
      for (const [key, val] of Object.entries(settings._deepseek_env)) {
        settings.env[key] = val;
      }
    }
    delete settings._deepseek_env;
  }
  console.log('[OK] 已切换回 DeepSeek API (deepseek-v4-pro)');
} else {
  console.log('用法: node switch-env.js [deepseek|mimo]');
  console.log('');
  console.log('当前配置:');
  console.log(`  AUTH_TOKEN: ${(settings.env.ANTHROPIC_AUTH_TOKEN || '').slice(0, 12)}...`);
  console.log(`  BASE_URL:   ${settings.env.ANTHROPIC_BASE_URL || '未设置'}`);
  console.log(`  MODEL:      ${settings.env.ANTHROPIC_MODEL || '未设置'}`);
  process.exit(0);
}

fs.writeFileSync(settingsPath, JSON.stringify(settings, null, 2));
console.log(`[OK] settings.json 已更新`);
