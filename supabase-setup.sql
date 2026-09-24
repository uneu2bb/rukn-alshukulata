-- ============================================
-- ركن الشوكلاتة - إعداد جداول Supabase
-- نفّذ هذا الكود من: Supabase Dashboard > SQL Editor > New query
-- ============================================

-- 1) جدول الأصناف
CREATE TABLE IF NOT EXISTS menu_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT DEFAULT '',
  price_try NUMERIC DEFAULT 0,
  price_syp NUMERIC DEFAULT 0,
  image_url TEXT DEFAULT '',
  category TEXT NOT NULL DEFAULT 'عام',
  category_icon TEXT DEFAULT '🍽️',
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2) جدول إعدادات الموقع
CREATE TABLE IF NOT EXISTS site_settings (
  key TEXT PRIMARY KEY,
  value TEXT DEFAULT '',
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_menu_items_category ON menu_items(category);
CREATE INDEX IF NOT EXISTS idx_menu_items_sort ON menu_items(category, sort_order);

ALTER TABLE menu_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "public_read_menu" ON menu_items;
DROP POLICY IF EXISTS "public_write_menu" ON menu_items;
DROP POLICY IF EXISTS "public_update_menu" ON menu_items;
DROP POLICY IF EXISTS "public_delete_menu" ON menu_items;

CREATE POLICY "public_read_menu"   ON menu_items FOR SELECT USING (true);
CREATE POLICY "public_write_menu"  ON menu_items FOR INSERT WITH CHECK (true);
CREATE POLICY "public_update_menu" ON menu_items FOR UPDATE USING (true);
CREATE POLICY "public_delete_menu" ON menu_items FOR DELETE USING (true);

DROP POLICY IF EXISTS "public_read_settings" ON site_settings;
DROP POLICY IF EXISTS "public_write_settings" ON site_settings;
DROP POLICY IF EXISTS "public_update_settings" ON site_settings;

CREATE POLICY "public_read_settings"   ON site_settings FOR SELECT USING (true);
CREATE POLICY "public_write_settings"  ON site_settings FOR INSERT WITH CHECK (true);
CREATE POLICY "public_update_settings" ON site_settings FOR UPDATE USING (true);

INSERT INTO site_settings (key, value) VALUES
  ('site_name', 'ركن الشوكلاتة'),
  ('logo', 'https://images.unsplash.com/photo-1606312619070-d48b4c652a52?w=120&h=120&fit=crop'),
  ('favicon', 'https://images.unsplash.com/photo-1606312619070-d48b4c652a52?w=64&h=64&fit=crop'),
  ('shop1_name', ''),
  ('shop1_phone', ''),
  ('shop2_name', ''),
  ('shop2_phone', ''),
  ('footer_desc', ''),
  ('admin_password', '2004')
ON CONFLICT (key) DO NOTHING;

INSERT INTO menu_items (name, description, price_try, price_syp, image_url, category, category_icon, sort_order) VALUES
('كيك الشوكولاتة الفاخر', 'طبقات غنية من الشوكولاتة البلجيكية', 28, 9800, 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600&h=400&fit=crop&q=80', 'حلويات الكيك', '🎂', 1),
('كيك الفانيليا', 'ناعم بنكهة الفانيليا', 24, 8400, 'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=600&h=400&fit=crop&q=80', 'حلويات الكيك', '🎂', 2),
('تشيز كيك', 'كريمي مع توت', 32, 11200, 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=600&h=400&fit=crop&q=80', 'حلويات الكيك', '🎂', 3),
('فانيليا فرنسية', 'كريمية 100%', 15, 5250, 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=600&h=400&fit=crop&q=80', 'البوظة', '🍦', 1),
('شوكولاتة داكنة', 'شوكولاتة 70%', 16, 5600, 'https://images.unsplash.com/photo-1497034822373-0e9d1fb2cc88?w=600&h=400&fit=crop&q=80', 'البوظة', '🍦', 2),
('تيراميسو', 'إيطالي أصلي', 30, 10500, 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=600&h=400&fit=crop&q=80', 'حلو غربي', '🧁', 1),
('براوني', 'شوكولاتة داكنة', 18, 6300, 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=600&h=400&fit=crop&q=80', 'حلو غربي', '🧁', 2),
('بقلاوة فستق', 'فستق حلبي', 22, 7700, 'https://images.unsplash.com/photo-1519677100203-a0e668c92439?w=600&h=400&fit=crop&q=80', 'حلو شرقي', '🥮', 1),
('كنافة نابلسية', 'جبنة عكاوي', 25, 8750, 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=600&h=400&fit=crop&q=80', 'حلو شرقي', '🥮', 2),
('آيس لاتيه', 'إسبريسو مع حليب بارد', 18, 6300, 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=600&h=400&fit=crop&q=80', 'قهوات باردة', '🧊', 1),
('كولد برو', 'تخمير 18 ساعة', 20, 7000, 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=600&h=400&fit=crop&q=80', 'قهوات باردة', '🧊', 2),
('إسبريسو', 'أرابيكا', 12, 4200, 'https://images.unsplash.com/photo-1510591509099-dee694411b31?w=600&h=400&fit=crop&q=80', 'قهوات ساخنة', '☕', 1),
('كابتشينو', 'رغوة حليب', 16, 5600, 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=600&h=400&fit=crop&q=80', 'قهوات ساخنة', '☕', 2),
('عصير برتقال', 'طازج 100%', 14, 4900, 'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?w=600&h=400&fit=crop&q=80', 'مشروبات وعصائر', '🧃', 1),
('ليموناضة', 'ليمون ونعناع', 12, 4200, 'https://images.unsplash.com/photo-1523677011780-c13bec071f9b?w=600&h=400&fit=crop&q=80', 'مشروبات وعصائر', '🧃', 2);
