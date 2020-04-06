SELECT
ROW_NUMBER() OVER (ORDER BY propinsi) as 'no',
propinsi as nama,
rekap_sekolah.kode_wilayah_propinsi as kode_wilayah,
rekap_sekolah.mst_kode_wilayah_propinsi as mst_kode_wilayah,

rekap_sekolah.id_level_wilayah_propinsi as id_level_wilayah,
null as induk_propinsi,
null as kode_wilayah_induk_propinsi,
null as induk_kabupaten,
null as kode_wilayah_induk_kabupaten,

sum(1) as sekolah_total,
sum(case when pmp.jumlah_kirim > 0 and bentuk_pendidikan_id in (5,6,13,15,53,54,55) then 1 else 0 end) as kirim_total,
(sum(case when bentuk_pendidikan_id in (5,6,13,15,53,54,55) then 1 else 0 end) - sum(case when pmp.jumlah_kirim > 0 and
bentuk_pendidikan_id in (5,6,13,15,53,54,55) then 1 else 0 end)) as sisa_total,
(case when sum(case when bentuk_pendidikan_id in (5,6,13,15,53,54,55) then 1 else 0 end) > 0 then (sum(case when
pmp.jumlah_kirim > 0 and bentuk_pendidikan_id in (5,6,13,15,53,54,55) then 1 else 0 end) / cast(sum(case when
bentuk_pendidikan_id in (5,6,13,15,53,54,55) then 1 else 0 end) as float) * 100) else 1 end) as persen_total,

sum(case when bentuk_pendidikan_id IN (5,53) then 1 else 0 end) as sekolah_sd,
sum(case when pmp.jumlah_kirim > 0 and bentuk_pendidikan_id IN (5,53) then 1 else 0 end) as kirim_sd,
(sum(case when bentuk_pendidikan_id IN (5,53) then 1 else 0 end) - sum(case when pmp.jumlah_kirim > 0 and
bentuk_pendidikan_id IN (5,53) then 1 else 0 end)) as sisa_sd,
(case when sum(case when bentuk_pendidikan_id IN (5,53) then 1 else 0 end) > 0 then (sum(case when pmp.jumlah_kirim > 0
and bentuk_pendidikan_id IN (5,53) then 1 else 0 end) / cast(sum(case when bentuk_pendidikan_id = 5 then 1 else 0 end)
as float) * 100) else 0 end) as persen_sd,

sum(case when bentuk_pendidikan_id IN (6,54) then 1 else 0 end) as sekolah_smp,
sum(case when pmp.jumlah_kirim > 0 and bentuk_pendidikan_id IN (6,54) then 1 else 0 end) as kirim_smp,
(sum(case when bentuk_pendidikan_id IN (6,54) then 1 else 0 end) - sum(case when pmp.jumlah_kirim > 0 and
bentuk_pendidikan_id IN (6,54) then 1 else 0 end)) as sisa_smp,
(case when sum(case when bentuk_pendidikan_id IN (6,54) then 1 else 0 end) > 0 then (sum(case when pmp.jumlah_kirim > 0
and bentuk_pendidikan_id IN (6,54) then 1 else 0 end) / cast(sum(case when bentuk_pendidikan_id = 6 then 1 else 0 end)
as float) * 100) else 0 end) as persen_smp,

sum(case when bentuk_pendidikan_id IN (13,55) then 1 else 0 end) as sekolah_sma,
sum(case when pmp.jumlah_kirim > 0 and bentuk_pendidikan_id IN (13,55) then 1 else 0 end) as kirim_sma,
(sum(case when bentuk_pendidikan_id IN (13,55) then 1 else 0 end) - sum(case when pmp.jumlah_kirim > 0 and
bentuk_pendidikan_id IN (13,55) then 1 else 0 end)) as sisa_sma,
(case when sum(case when bentuk_pendidikan_id IN (13,55) then 1 else 0 end) > 0 then (sum(case when pmp.jumlah_kirim > 0
and bentuk_pendidikan_id IN (13,55) then 1 else 0 end) / cast(sum(case when bentuk_pendidikan_id = 13 then 1 else 0 end)
as float) * 100) else 0 end) as persen_sma,

sum(case when bentuk_pendidikan_id = 15 then 1 else 0 end) as sekolah_smk,
sum(case when pmp.jumlah_kirim > 0 and bentuk_pendidikan_id = 15 then 1 else 0 end) as kirim_smk,
(sum(case when bentuk_pendidikan_id = 15 then 1 else 0 end) - sum(case when pmp.jumlah_kirim > 0 and
bentuk_pendidikan_id = 15 then 1 else 0 end)) as sisa_smk,
(case when sum(case when bentuk_pendidikan_id = 15 then 1 else 0 end) > 0 then (sum(case when pmp.jumlah_kirim > 0 and
bentuk_pendidikan_id = 15 then 1 else 0 end) / cast(sum(case when bentuk_pendidikan_id = 15 then 1 else 0 end) as float)
* 100) else 0 end) as persen_smk,

max(pmp.sync_terakhir) as tanggal_rekap_terakhir
FROM
rekap_sekolah
LEFT JOIN rekap_pengiriman_pmp pmp on pmp.sekolah_id = rekap_sekolah.sekolah_id and pmp.tahun_ajaran_id = '2019'
WHERE
semester_id = '20191'
AND rekap_sekolah.tahun_ajaran_id = '2019'

AND rekap_sekolah.bentuk_pendidikan_id IN (5,53,6,54,13,55,15)
AND rekap_sekolah.status_sekolah IN (1,2)

AND rekap_sekolah.bentuk_pendidikan_id != 29
AND soft_delete = 0
GROUP BY
propinsi,
rekap_sekolah.kode_wilayah_propinsi,
rekap_sekolah.mst_kode_wilayah_propinsi,
rekap_sekolah.id_level_wilayah_propinsi,
propinsi,

kode_wilayah_propinsi


ORDER BY
persen_total desc