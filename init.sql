-- 启用 pgvector 扩展
CREATE EXTENSION IF NOT EXISTS vector;

-- 启用 Apache AGE 扩展
CREATE EXTENSION IF NOT EXISTS age;

-- 验证加载（可选）
LOAD 'age';

-- add search_path 
ALTER role salesaidev IN DATABASE salesai SET search_path TO ag_catalog, "$user", public;
