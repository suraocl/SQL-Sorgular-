CREATE TABLE birimler (
    birim_id INT PRIMARY KEY,
    birim_ad CHAR(25) NOT NULL
);

CREATE TABLE calisanlar (
    calisan_id INT PRIMARY KEY,
    ad CHAR(25),
    soyad CHAR(25),
    maas INT,
    katilmaTarihi DATETIME,
    calisan_birim_id INT NOT NULL,
    FOREIGN KEY (calisan_birim_id) REFERENCES birimler(birim_id)
);

CREATE TABLE ikramiye (
    ikramiye_calisan_id INT NOT NULL,
    ikramiye_ucret INT,
    ikramiye_tarih DATETIME,
    FOREIGN KEY (ikramiye_calisan_id) REFERENCES calisanlar(calisan_id)
);

CREATE TABLE unvan (
    unvan_calisan_id INT NOT NULL,
    unvan_calisan CHAR(25),
    unvan_tarih DATETIME,
    FOREIGN KEY (unvan_calisan_id) REFERENCES calisanlar(calisan_id)
);


INSERT INTO birimler (birim_id, birim_ad) VALUES
(1, 'Yazýlým'),
(2, 'Donaným'),
(3, 'Güvenlik');


INSERT INTO calisanlar (calisan_id, ad, soyad, maas, katilmaTarihi, calisan_birim_id) VALUES
(1, 'Ýsmail', 'Ýçeri', 100000, '2014-02-20', 1),
(2, 'Hami', 'Satýlmýþ', 80000, '2014-06-11', 1),
(3, 'Dumuþ', 'Þahin', 300000, '2014-02-20', 2),
(4, 'Kaðan', 'Yazar', 50000, '2014-02-20', 3),
(5, 'Meryem', 'Soysalýd', 500000, '2014-06-11', 2),
(6, 'Duygu', 'Akþehir', 200000, '2014-06-11', 2),
(7, 'Kübra', 'Seyhan', 75000, '2014-01-20', 3),
(8, 'Gülcan', 'Yýldýz', 90000, '2014-04-11', 3);


INSERT INTO ikramiye (ikramiye_calisan_id, ikramiye_ucret, ikramiye_tarih) VALUES
(1, 5000, '2016-02-20'),
(2, 3000, '2016-06-11'),
(3, 4000, '2016-06-11'),
(1, 2000, '2016-02-20'),
(2, 3500, '2016-06-11');

INSERT INTO unvan (unvan_calisan_id, unvan_calisan, unvan_tarih) VALUES
(1, 'Yönetici', '2016-02-20'),
(2, 'Personel', '2016-06-11'),
(8, 'Personel', '2016-06-11'),
(5, 'Müdür', '2016-06-11'),
(4, 'Yönetici Yardýmcýsý', '2016-06-11'),
(6, 'Personel', '2016-06-11'),
(7, 'Takým Lideri', '2016-06-11'),
(3, 'Takým Lideri', '2016-06-11');

----------------------------------------------------------------------------------------

SELECT c.ad, c.soyad, c.maas
FROM calisanlar c
JOIN birimler b ON c.calisan_birim_id = b.birim_id
WHERE b.birim_ad IN ('Yazýlým', 'Donaným');

-------------------------------------------------------------------------------------

SELECT ad, soyad, maas
FROM calisanlar
WHERE maas = (
    SELECT MAX(maas) FROM calisanlar
);
----------------------------------------------

SELECT b.birim_ad, COUNT(c.calisan_id) AS calisan_sayisi
FROM birimler b
JOIN calisanlar c ON b.birim_id = c.calisan_birim_id
GROUP BY b.birim_ad;
---------------------------


SELECT unvan_calisan, COUNT(unvan_calisan_id) AS calisan_sayisi
FROM unvan
GROUP BY unvan_calisan
HAVING COUNT(unvan_calisan_id) > 1;


SELECT ad, soyad, maas
FROM calisanlar
WHERE maas BETWEEN 50000 AND 100000;

----------------------------------------

SELECT 
    c.ad, 
    c.soyad, 
    b.birim_ad, 
    u.unvan_calisan, 
    i.ikramiye_ucret
FROM ikramiye i
JOIN calisanlar c ON i.ikramiye_calisan_id = c.calisan_id
JOIN birimler b ON c.calisan_birim_id = b.birim_id
JOIN unvan u ON c.calisan_id = u.unvan_calisan_id;


---------------------------

SELECT 
    c.ad, 
    c.soyad, 
    u.unvan_calisan
FROM unvan u
JOIN calisanlar c ON u.unvan_calisan_id = c.calisan_id
WHERE u.unvan_calisan IN ('Yönetici', 'Müdür');

----------------------------------------------------


SELECT c.ad, c.soyad, c.maas, b.birim_ad
FROM calisanlar c
JOIN birimler b ON c.calisan_birim_id = b.birim_id
WHERE c.maas = (
    SELECT MAX(c2.maas)
    FROM calisanlar c2
    WHERE c2.calisan_birim_id = c.calisan_birim_id
);
