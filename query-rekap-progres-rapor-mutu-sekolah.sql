SELECT
ROW_NUMBER() OVER (ORDER BY nama) as 'no',
rekap_sekolah.sekolah_id,
nama,
npsn,
status_sekolah,
CASE status_sekolah
WHEN 1 THEN 'Negeri'
WHEN 2 THEN 'Swasta'
ELSE '-' END AS status,
bentuk_pendidikan_id,
CASE
WHEN bentuk_pendidikan_id = 1 THEN 'TK'
WHEN bentuk_pendidikan_id = 2 THEN 'KB'
WHEN bentuk_pendidikan_id = 3 THEN 'TPA'
WHEN bentuk_pendidikan_id = 4 THEN 'SPS'
WHEN bentuk_pendidikan_id = 5 THEN 'SD'
WHEN bentuk_pendidikan_id = 6 THEN 'SMP'
WHEN bentuk_pendidikan_id IN (7, 8, 14, 29) THEN 'SLB'
WHEN bentuk_pendidikan_id = 13 THEN 'SMA'
WHEN bentuk_pendidikan_id = 15 THEN 'SMK'
WHEN bentuk_pendidikan_id = 53 THEN 'SPK SD'
WHEN bentuk_pendidikan_id = 54 THEN 'SPK SMP'
WHEN bentuk_pendidikan_id = 55 THEN 'SPK SMA'
ELSE '-' END AS bentuk,
rekap_sekolah.kecamatan,
rekap_sekolah.kabupaten,
rekap_sekolah.propinsi,
rekap_sekolah.kode_wilayah_kecamatan,
rekap_sekolah.mst_kode_wilayah_kecamatan,
rekap_sekolah.id_level_wilayah_kecamatan,
rekap_sekolah.kode_wilayah_kabupaten,
rekap_sekolah.mst_kode_wilayah_kabupaten,
rekap_sekolah.id_level_wilayah_kabupaten,
rekap_sekolah.kode_wilayah_propinsi,
rekap_sekolah.mst_kode_wilayah_propinsi,
rekap_sekolah.id_level_wilayah_propinsi,
-- ISNULL(pmp.jumlah_kirim,0) as jumlah_kirim,
ISNULL(pmp.hitung_rapor_mutu,0) as hitung_rapor_mutu,
ISNULL(pmp.jumlah_pengguna,0) as jumlah_pengguna,
ISNULL(pmp.jumlah_pengguna_mengerjakan,0) as jumlah_pengguna_mengerjakan,
ISNULL(pmp.kepsek_total,0) as kepsek_total,
ISNULL(pmp.kepsek_mengerjakan,0) as kepsek_mengerjakan,
ISNULL(pmp.kepsek_persen,0) as kepsek_persen,
ISNULL(pmp.pd_total,0) as pd_total,
ISNULL(pmp.pd_mengerjakan,0) as pd_mengerjakan,
ISNULL(pmp.pd_persen,0) as pd_persen,
ISNULL(pmp.ptk_total,0) as ptk_total,
ISNULL(pmp.ptk_mengerjakan,0) as ptk_mengerjakan,
ISNULL(pmp.ptk_persen,0) as ptk_persen,
ISNULL(pmp.komite_total,0) as komite_total,
ISNULL(pmp.komite_mengerjakan,0) as komite_mengerjakan,
ISNULL(pmp.komite_persen,0) as komite_persen,
ISNULL(pmp.verifikasi_pengawas,0) as verifikasi_pengawas,
pmp.sync_terakhir as sync_terakhir,
rekap_sekolah.tanggal as tanggal_rekap_terakhir
FROM
rekap_sekolah WITH(NOLOCK)
LEFT JOIN rekap_pengiriman_pmp pmp on pmp.sekolah_id = rekap_sekolah.sekolah_id and pmp.tahun_ajaran_id = '2019'
WHERE
semester_id = '20191'
AND rekap_sekolah.tahun_ajaran_id = '2019'
AND rekap_sekolah.mst_kode_wilayah_propinsi = '000000'
AND soft_delete = 0
AND rekap_sekolah.bentuk_pendidikan_id IN (5,53,6,54,13,55,15)
AND rekap_sekolah.status_sekolah IN (1,2)