clear;

syms={'MYL', 'VAL', 'TTWO', 'CDIC', 'LI', 'LWSN', 'NFLD', 'MOS', 'SCHN', 'TGIS', 'BKRS', 'EZEM', 'ESIO', 'EMSN.VX', 'FRS', 'LINK.PK', 'JEL.S', 'HANS' };
truth=[0        0    0          1    1    1        1       1       0      0       1       0       0       1          1       1          1      0];
[earnann]=parseEarningsCalendarFromEarningsDotCom(20070409, 20070410, syms);

assert(all(earnann==truth)); 