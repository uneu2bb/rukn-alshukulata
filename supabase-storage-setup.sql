-- ============================================
-- ركن الشوكلاتة - إعداد Supabase Storage
-- نفّذ من: Supabase Dashboard > SQL Editor
-- ============================================

-- 1) إنشاء Bucket علني باسم menu-images
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'menu-images',
  'menu-images',
  true,
  5242880,
  ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif', 'image/jpg']
)
ON CONFLICT (id) DO UPDATE SET
  public = true,
  file_size_limit = 5242880;

-- 2) سياسات الوصول (قراءة ورفع عامة للتجربة)
-- ملاحظة: لاحقاً يُفضّل تقييد الرفع بحساب أدمن فقط

DROP POLICY IF EXISTS "menu_images_public_read" ON storage.objects;
DROP POLICY IF EXISTS "menu_images_public_insert" ON storage.objects;
DROP POLICY IF EXISTS "menu_images_public_update" ON storage.objects;
DROP POLICY IF EXISTS "menu_images_public_delete" ON storage.objects;

CREATE POLICY "menu_images_public_read"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'menu-images');

CREATE POLICY "menu_images_public_insert"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'menu-images');

CREATE POLICY "menu_images_public_update"
  ON storage.objects FOR UPDATE
  USING (bucket_id = 'menu-images');

CREATE POLICY "menu_images_public_delete"
  ON storage.objects FOR DELETE
  USING (bucket_id = 'menu-images');
