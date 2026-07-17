-- ============================================================
-- 症状/标签字典数据导入
-- ============================================================

USE tcm_hospital;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE symptom_dict;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '头痛', 1, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '眩晕', 2, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '咳嗽', 3, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '发热', 4, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '腹痛', 5, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '胸闷', 6, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '心悸', 7, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '失眠', 8, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '呕吐', 9, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '腹泻', 10, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '便秘', 11, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '腰酸', 12, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '乏力', 13, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '气喘', 14, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '咽痛', 15, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '胃痛', 16, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '水肿', 17, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '耳鸣', 18, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '出汗', 19, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '口干', 20, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '鼻塞', 21, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '关节痛', 22, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '尿频', 23, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '月经不调', 24, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('chief_complaint', '胁痛', 25, 0, 0);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '诱因', '受凉', 26, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '诱因', '劳累', 27, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '诱因', '饮食不节', 28, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '诱因', '情志刺激', 29, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '诱因', '外伤', 30, 0, 0);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '特征', '持续性', 31, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '特征', '阵发性', 32, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '特征', '进行性加重', 33, 0, 0);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '特征', '反复发作', 34, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '特征', '夜间加重', 35, 0, 0);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '伴随', '恶寒发热', 36, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '伴随', '自汗盗汗', 37, 0, 0);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '伴随', '恶心呕吐', 38, 0, 0);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '伴随', '食欲不振', 39, 1, 5);
INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight) VALUES
('present_illness', '伴随', '口渴引饮', 40, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('past_history', '高血压', 41, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('past_history', '糖尿病', 42, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('past_history', '心脏病', 43, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('past_history', '肝炎', 44, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('past_history', '结核', 45, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('past_history', '手术史', 46, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('past_history', '外伤史', 47, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('past_history', '过敏史', 48, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('allergy', '青霉素过敏', 49, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('allergy', '磺胺类过敏', 50, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('allergy', '花粉过敏', 51, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('allergy', '食物过敏', 52, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('personal', '吸烟', 53, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('personal', '饮酒', 54, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('personal', '喜食辛辣', 55, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('personal', '喜食生冷', 56, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('personal', '久坐', 57, 0, 0);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('personal', '熬夜', 58, 1, 5);
INSERT INTO symptom_dict (category, label, sort_order, is_common, weight) VALUES
('personal', '压力大', 59, 1, 5);
