#!/usr/bin/env node
/**
 * switch-api.js — 统一管理 Claude Code、VSCode 等平台的模型配置
 *
 * 用法:
 *   node ~/.claude/bin/switch-api.js mimo          ← 切换到 mimo-v2.5 (日常)
 *   node ~/.claude/bin/switch-api.js mimo-pro      ← 切换到 mimo-v2.5-pro (复杂任务)
 *   node ~/.claude/bin/switch-api.js deepseek      ← 切换到 DeepSeek
 *   node ~/.claude/bin/switch-api.js hybrid        ← 混合模式 (mimo主 + deepseek子代理)
 *   node ~/.claude/bin/switch-api.js               ← 查看当前状态
 *   node ~/.claude/bin/switch-api.js --list        ← 列出所有配置
 *
 * 说明:
 *   - 同时更新 Claude Code CLI 和 VSCode 扩展的配置
 *   - API Key 从环境变量读取（~/.claude/.env.secrets 中定义）
 *   - 切换后需要重启 Claude Code 会话
 */

const fs = require('fs');
const path = require('path');

const HOME = require('os').homedir();
const CLAUDE_DIR = process.env.CLAUDE_CONFIG_DIR || path.join(HOME, '.claude');
const SETTINGS_PATH = path.join(CLAUDE_DIR, 'settings.json');
const VSCODE_SETTINGS_PATH = path.join(HOME, 'AppData', 'Roaming', 'Code', 'User', 'settings.json');

// 从环境变量读取 API Key（由 .env.secrets 提供）
const keys = {
  deepseek: process.env.DEEPSEEK_API_KEY || '',
  mimo: process.env.MIMO_API_KEY || '',
};

const CONFIGS = {
  mimo: {
    label: 'Mimo v2.5 (日常使用)',
    description: '小米 mimo-v2.5，适合日常任务',
    env: {
      ANTHROPIC_AUTH_TOKEN: keys.mimo,
      ANTHROPIC_BASE_URL: 'https://api.xiaomimimo.com/anthropic',
      ANTHROPIC_MODEL: 'mimo-v2.5',
      ANTHROPIC_DEFAULT_HAIKU_MODEL: 'mimo-v2.5',
      ANTHROPIC_DEFAULT_SONNET_MODEL: 'mimo-v2.5',
      ANTHROPIC_DEFAULT_OPUS_MODEL: 'mimo-v2.5',
      CLAUDE_CODE_SUBAGENT_MODEL: 'mimo-v2.5',
    },
  },
  'mimo-pro': {
    label: 'Mimo v2.5 Pro (复杂任务)',
    description: '小米 mimo-v2.5-pro，1M上下文，适合复杂任务',
    env: {
      ANTHROPIC_AUTH_TOKEN: keys.mimo,
      ANTHROPIC_BASE_URL: 'https://api.xiaomimimo.com/anthropic',
      ANTHROPIC_MODEL: 'mimo-v2.5-pro',
      ANTHROPIC_DEFAULT_HAIKU_MODEL: 'mimo-v2.5-pro',
      ANTHROPIC_DEFAULT_SONNET_MODEL: 'mimo-v2.5-pro',
      ANTHROPIC_DEFAULT_OPUS_MODEL: 'mimo-v2.5-pro',
      CLAUDE_CODE_SUBAGENT_MODEL: 'mimo-v2.5-pro',
    },
  },
  deepseek: {
    label: 'DeepSeek v4',
    description: 'DeepSeek v4 模型，备选方案',
    env: {
      ANTHROPIC_AUTH_TOKEN: keys.deepseek,
      ANTHROPIC_BASE_URL: 'https://api.deepseek.com/anthropic',
      ANTHROPIC_MODEL: 'deepseek-v4-pro',
      ANTHROPIC_DEFAULT_HAIKU_MODEL: 'deepseek-v4-flash',
      ANTHROPIC_DEFAULT_SONNET_MODEL: 'deepseek-v4-pro',
      ANTHROPIC_DEFAULT_OPUS_MODEL: 'deepseek-v4-pro',
      CLAUDE_CODE_SUBAGENT_MODEL: 'deepseek-v4-flash',
    },
  },
  hybrid: {
    label: '混合模式 (Mimo主 + DeepSeek子代理)',
    description: '主模型用 mimo-pro，子代理用 deepseek-flash 节省成本',
    env: {
      ANTHROPIC_AUTH_TOKEN: keys.mimo,
      ANTHROPIC_BASE_URL: 'https://api.xiaomimimo.com/anthropic',
      ANTHROPIC_MODEL: 'mimo-v2.5-pro',
      ANTHROPIC_DEFAULT_HAIKU_MODEL: 'mimo-v2.5',
      ANTHROPIC_DEFAULT_SONNET_MODEL: 'mimo-v2.5-pro',
      ANTHROPIC_DEFAULT_OPUS_MODEL: 'mimo-v2.5-pro',
      CLAUDE_CODE_SUBAGENT_MODEL: 'deepseek-v4-flash',
    },
  },
};

// ---- 辅助函数 ----

// 读取 JSON 文件
function readJson(filePath) {
  try {
    return JSON.parse(fs.readFileSync(filePath, 'utf-8'));
  } catch (err) {
    console.error(`读取 ${filePath} 失败:`, err.message);
    return null;
  }
}

// 写入 JSON 文件
function writeJson(filePath, data) {
  fs.writeFileSync(filePath, JSON.stringify(data, null, 2) + '\n', 'utf-8');
}

// 检测当前使用的配置
function detectCurrentConfig(settings) {
  const env = settings.env || {};
  const url = env.ANTHROPIC_BASE_URL || '';
  const model = env.ANTHROPIC_MODEL || '';

  if (url.includes('xiaomimimo') && model.includes('-pro')) return 'mimo-pro';
  if (url.includes('xiaomimimo')) return 'mimo';
  if (url.includes('deepseek')) return 'deepseek';
  return 'unknown';
}

// 更新 Claude Code 配置
function updateClaudeSettings(config) {
  const settings = readJson(SETTINGS_PATH);
  if (!settings) return false;

  if (!settings.env) settings.env = {};

  for (const [key, value] of Object.entries(config.env)) {
    settings.env[key] = value;
  }

  // 清理 ANTHROPIC_API_KEY 防止冲突
  delete settings.env.ANTHROPIC_API_KEY;

  writeJson(SETTINGS_PATH, settings);
  return true;
}

// 更新 VSCode 配置
function updateVSCodeSettings(config) {
  if (!fs.existsSync(VSCODE_SETTINGS_PATH)) {
    console.log('⚠ VSCode 配置文件不存在，跳过');
    return false;
  }

  const vscodeSettings = readJson(VSCODE_SETTINGS_PATH);
  if (!vscodeSettings) return false;

  // 构建 environmentVariables 数组
  const envVars = [
    { name: 'ALL_PROXY', value: 'socks5://127.0.0.1:7897' },
    { name: 'ANTHROPIC_AUTH_TOKEN', value: config.env.ANTHROPIC_AUTH_TOKEN },
    { name: 'ANTHROPIC_BASE_URL', value: config.env.ANTHROPIC_BASE_URL },
    { name: 'ANTHROPIC_MODEL', value: config.env.ANTHROPIC_MODEL },
    { name: 'ANTHROPIC_DEFAULT_HAIKU_MODEL', value: config.env.ANTHROPIC_DEFAULT_HAIKU_MODEL },
    { name: 'ANTHROPIC_DEFAULT_OPUS_MODEL', value: config.env.ANTHROPIC_DEFAULT_OPUS_MODEL },
    { name: 'ANTHROPIC_DEFAULT_SONNET_MODEL', value: config.env.ANTHROPIC_DEFAULT_SONNET_MODEL },
    { name: 'CLAUDE_CODE_EFFORT_LEVEL', value: 'high' },
    { name: 'CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS', value: '1' },
    { name: 'CLAUDE_CODE_MAX_OUTPUT_TOKENS', value: '16000' },
    { name: 'CLAUDE_CODE_SKIP_FAST_MODE_NETWORK_ERRORS', value: '1' },
    { name: 'CLAUDE_CODE_SKIP_UPDATE_CHECK', value: '1' },
    { name: 'CLAUDE_CODE_SUBAGENT_MODEL', value: config.env.CLAUDE_CODE_SUBAGENT_MODEL },
    { name: 'MAX_THINKING_TOKENS', value: '8000' },
  ];

  vscodeSettings['claudeCode.environmentVariables'] = envVars;
  writeJson(VSCODE_SETTINGS_PATH, vscodeSettings);
  return true;
}

// ---- 主逻辑 ----

const mode = process.argv[2];

// 无参数 → 显示当前状态
if (!mode) {
  const settings = readJson(SETTINGS_PATH);
  if (!settings) process.exit(1);

  const current = detectCurrentConfig(settings);
  const env = settings.env || {};

  console.log('');
  console.log('📋 当前配置');
  console.log('─'.repeat(40));

  if (CONFIGS[current]) {
    console.log(`  名称: ${current}`);
    console.log(`  描述: ${CONFIGS[current].description}`);
  } else {
    console.log(`  名称: 未知配置`);
  }

  console.log(`  模型: ${env.ANTHROPIC_MODEL || '(未设置)'}`);
  console.log(`  端点: ${env.ANTHROPIC_BASE_URL || '(未设置)'}`);
  console.log(`  子代理: ${env.CLAUDE_CODE_SUBAGENT_MODEL || '(未设置)'}`);
  console.log('');
  console.log('用法:');
  console.log('  node ~/.claude/bin/switch-api.js <配置名>   切换配置');
  console.log('  node ~/.claude/bin/switch-api.js --list    列出所有配置');
  console.log('');
  return;
}

// --list → 列出所有配置
if (mode === '--list' || mode === '-l') {
  console.log('');
  console.log('📋 可用的模型配置');
  console.log('─'.repeat(50));
  console.log('');

  for (const [name, config] of Object.entries(CONFIGS)) {
    console.log(`  ${name}`);
    console.log(`    ${config.description}`);
    console.log(`    模型: ${config.env.ANTHROPIC_MODEL}`);
    console.log(`    子代理: ${config.env.CLAUDE_CODE_SUBAGENT_MODEL}`);
    console.log('');
  }

  return;
}

// 切换配置
if (!CONFIGS[mode]) {
  console.error(`❌ 未知配置: ${mode}`);
  console.error('可用配置:', Object.keys(CONFIGS).join(', '));
  process.exit(1);
}

const config = CONFIGS[mode];

// 检查 API Key 是否可用
const keyVar = config.env.ANTHROPIC_BASE_URL.includes('deepseek') ? 'DEEPSEEK_API_KEY' : 'MIMO_API_KEY';
const keyVal = config.env.ANTHROPIC_AUTH_TOKEN;
if (!keyVal) {
  console.error(`⚠ ${keyVar} 环境变量未设置`);
  console.error('   请检查 ~/.claude/.env.secrets 文件');
  process.exit(1);
}

console.log('');
console.log(`🔄 切换到: ${config.label}`);
console.log('─'.repeat(50));

// 更新 Claude Code
const claudeOk = updateClaudeSettings(config);
console.log(`${claudeOk ? '✅' : '❌'} Claude Code CLI 配置`);

// 更新 VSCode
const vscodeOk = updateVSCodeSettings(config);
console.log(`${vscodeOk ? '✅' : '⏭️'} VSCode 扩展配置`);

// 显示结果
console.log('');
console.log('📋 配置详情');
console.log(`  主模型: ${config.env.ANTHROPIC_MODEL}`);
console.log(`  Haiku: ${config.env.ANTHROPIC_DEFAULT_HAIKU_MODEL}`);
console.log(`  Sonnet: ${config.env.ANTHROPIC_DEFAULT_SONNET_MODEL}`);
console.log(`  Opus: ${config.env.ANTHROPIC_DEFAULT_OPUS_MODEL}`);
console.log(`  子代理: ${config.env.CLAUDE_CODE_SUBAGENT_MODEL}`);
console.log(`  端点: ${config.env.ANTHROPIC_BASE_URL}`);
console.log('');
console.log('⚠ 重启 Claude Code 和 VSCode 后完全生效');
