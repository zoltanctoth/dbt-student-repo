# Dot-source this file before running dbt:
#   . .\set-env.ps1
# or . ..\set-env.ps1 if you're running the script from airbnb/ folder
# !! Do this every time you open a new PowerShell terminal, as env vars are not persisted !!
# First-time only (one-shot per machine):
#   Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

$env:SNOWFLAKE_ACCOUNT = "scbjarf-ss60166"
$env:DBT_USER = "dbt"
$env:PRIVATE_KEY_PASSPHRASE = "q"
$env:PRIVATE_KEY = @"
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIIFNTBfBgkqhkiG9w0BBQ0wUjAxBgkqhkiG9w0BBQwwJAQQbg38REu4Jyd+oIZL
4KGtkgICCAAwDAYIKoZIhvcNAgkFADAdBglghkgBZQMEASoEELrtDYJsn9HlJ+t/
6IKz0icEggTQj4LO0A/9hnzXBSupqM40kEgWxkM2bto2PegD/xgGOujOGh5ynaFo
0D+c4ua36gV4HQ4l+7RNAbdcOcrraLE79A6hhlPt4vQRWmjoSvD3eQkJwYMstPKf
r0khHyAqq1Y3RuoidC55wHe2DhF7iSvZDmbxc+HNwc3gs/uGom9Y3G33odsHBL5c
f9ULkODwrafjYiuF9bxxFo41KDrXqYi4ipFTpUHFoMZSor4gH+vZ06LMUUneIAQl
1VFY2gW0c+pfxIrxU/Uv3F5vo4HLSyRa2mjvpAB9DW4RyzMVwMf5JB18AR4kEYy/
fsHlG0rGa5gnkYi0GwTNvWK+1G7JmaMUCMNy495hL0vOxK2FnEmW9BIEyBBVDlu4
3SzFZPPBSyo3N3KDGTgilOmlvH1zuCDksn7BdRHKraV7bsVDta0QqqucidmMJAqA
Dw917m4znqru6xYYalnbo9hTLm9D/x/7JrgCNAqwzi9V7qKkzbASGh7mNbQLmYV7
G93425LHb78NWXIJ7ljp/eEOOovAUsLiWhVAc2twcgp6JXqC7kFrn61nrU9thkX4
zynDXUmY51N0mqSrEbNfUZgyta/K8Lt90jz65sJNC9beMWnrtPgZCQ01QiAcoORY
0TGXfK/UZ9rQ7rw2Sk9Zx06gSfUTY+TedU+KVG36w04X3cqM8FczGWPPlPkl2w3B
eIAtnV4Xr/BQlBvj8MyZYLvYKtFZISVy2Fb7e2MgpYmgeCeZEjHXzrx4MdS0sxBa
rmjo3UHNQykKq3Yf66m9dJnWQm0sIYNHkiZGwYDZ8R8qRSnm+InfTIFZ2jlmdThi
I43xV8i7clP4WScRz5e27/uSHF/ume+KwssTLSEmGGpmnItouw8MwPQD/OjrcUMo
TQ7MVO6e1NTJy/EY+v8Fai2lRMdStBtVqa1OjYFiI1f3WHM2lxNkW5z2E7gZyDQ5
YVMEzPXt8QaDh1i/yN7M6Q9hjmdGmh1I5MO+zzUiSh14jgx6uOI1OuGkILsGaynu
sXvOTXPK3MGO5NV5TBlqogipFhG+foHOSTSayjaddFUiZXZGaEMupmDp3daxJqmb
m+zJtFdFSoSKjbTGapDiHV2C/rN+XShVYsIvtT8i3s/cPrn95v+Q6U7uQrM+yCBX
G6PyhCtAi1tnFXrpdrHZ01ZO2OWxCEIwrPBKfK9m3sa51DLoDYN7FoDkW1zKOfjA
+MhmoCLX7hBioD/pMnkxAKFZi4S3u2sWmewy3BZzuwmPlpz6mr/XkgQ5azGeyrGq
eN/iWfMAzyTl+9JCdMIANj5r43zF2BhqkSHCZ0DTQh59XSmT576cD9g1YRd7cpdm
0CGHo1lFGPVqugB0e9z/Vs4eHDCH0I/dswjpVitbzk/LSXfrfvzHm66xl9tbSkw8
UCnrmEXYvRMoftN70BpnYoO+jkhwv5c+lUvdUDYWmGx6JQcLFxEqD7D5tFhDuuwI
HT7WQJm0MDRDp+In0f8zaRMuux2C4nfO6RV+/AxSy8ujT79PGQ0k0tOBBKnSZ3E7
AxRyCYB7ugP3yPdnu4z3dpyP1447O4FbzMVMsmRoNat8pDvd0vFKmAilFA+MBbDI
CjFaobzj2yjcohw9v/15dA4GvtGwp7lllHh5cotWn14mlpBGxMuQekg=
-----END ENCRYPTED PRIVATE KEY-----
"@
