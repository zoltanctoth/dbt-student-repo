# Preset Instructions

## SQLAlchemy URL
```
snowflake://preset@ahhzsxq-sd94945/AIRBNB?role=REPORTER&warehouse=COMPUTE_WH
```

## Security JSON
```json
{
    "auth_method": "keypair",
    "auth_params": {
        "privatekey_body": "-----BEGIN ENCRYPTED PRIVATE KEY-----\nMIIFNTBfBgkqhkiG9w0BBQ0wUjAxBgkqhkiG9w0BBQwwJAQQ36RcgV71hCzBqERe\nypo9RgICCAAwDAYIKoZIhvcNAgkFADAdBglghkgBZQMEASoEEGa75xyRURzJjxE1\nsjsDGYIEggTQ5RxllooIux8T8g/YehgM1L16AvKOnhmEtH+WTOy/1sFY+Ffsolt+\nfnIZMRoaKYlz4hVPtaU8zlh6V+Gu09An0fPS/SzSA2T5sFOMoZMkJS4gw8DzTxa/\nwnSxE39Lcc0YyMiP6P85lPTWQsJ/ILLPIaOknMz6r6TiuEgunL/OFI7k8YLk9NeU\ncGb/24jxJ3cR64yaYqFyxiU60wQ0e86IOKqMMQRH5TmN2epGQp3FqAtpv2vZHcpo\nm7lK+mJl9qhKIA2nk3vnUyUeAe1PLOdm0SSYsp9M+9qJ4Fx0vUakZS5rWftBOLtw\nYXzFIBbLwGDy4zaplPKnRIrp0iiHB1rhfNKTOK8hBmfNSLsIeo4nIrrXwjnr4ZBN\n4ZiPNx/u65V3xsSGG+kWNweGYqvinXMv+FSI/CaMsh9X+9uPZdy68sv5IKgyG5Dy\nv52xAhJa/TuBK0kiParSGRS+K3nDZJ0ccVyVsi6sxgS0Y29UF/Gz6FtUEQMCK3GJ\nafEUCr7dIwU/Hiz9eUcEMO1mGKsHHRmv57unjOmjSz1wHCAe8CBRZTBR1dg5e50U\niJ7XzjbqS1Eye6TIllVJj3n6VppZXqq0CJ+4UH1gGYyh2GOrKMYPS99aZL8Vy6Z+\n/bdjiA6vmJWiNUbwEIsGyh3Tfhmqv8wl/iN8IcNTlPo2oPsnOfp4EaP/pif15R2Q\n82cuP7ftNJAmoyt/zUnSUtz1XMnYhhCNcE1IVd8n3/imtIFTF7YRoZALRAJ/V+K3\nI5n12stoooA0Hp/PPeXDs4QbLbY65MUxaqvRDdPk7aYrQ33FVksvK8t54AsU12j8\nINnipssNxJJNA0DtroNIqeDEJSpKx4sizyW1oW0sIINkyqXqQ0sqEMFQvODzINSp\nEy0X5SXWHI+rniVKOju+jY8HOyblOibFEVS123BVxtYPL065tvdgwCDHsCsmAk1R\nF/0Nci5FqGlVWEtbdIeL7YBCqPMRoQN+ZkwrloQoWLxLNbHNNBRW4CXmpE4X1n1d\nxpUAsxahMQGxnrn7P3ua+t7NWbTR3hLvrXRxdJwU6oQPAYptIlI4Zsx9ymlkFWV+\n5YlM50jHry5Hyirz1H6Qh8vV1xI1tiBoVhdVI41q6rNkey8KZZIernBDg65MQir/\nZtzqAQjMiZYaeZ/FVTB3vEBD46LK+N5QH4i7G9gZFKcuJwYs0sii2L4VqKJgspfv\n0vL7pObKObt2GkeB5aL1ByobHu/AccAiK+te2N6CkrR+pt/Hh1lKKeXwNvDkvSPX\noR+kMyGEJYkeLRLyAya6NXlW1+5EgVIJp96CztElCDQKOvCnjcm5C9EH9ZOmf9gs\nZRXmoUoDwacOdsPbC9w0FFtF+aCuS/PtkZIiOeUFElib0Pr9BO7SfQTn9SJa5DAM\nt3veDuA1nqCnJwKx5okNIJIvTyzIRNU+RcsQCvf71dSiP1bLy1NbSpL2RN1C/S14\niN3491M5Ylo44J/1Db+9701PAa8vd9bV03GYWrx+QgTYjaACwEVhln8YU5sHZD1K\ni7BbNk/vDyZ1e8B+eueoPq0y5RPCfKZ68PQoIH3EqQ01ECQS+uKz+Hfbn4yVqIr7\nrtV6Jx0UXgz6x8lb2GXtW8u/MegCMhqWdP1PD+BWs5a2KFDva8nXILs=\n-----END ENCRYPTED PRIVATE KEY-----\n",
        "privatekey_pass": "q"
    }
}
```

## Instructions
1. Use the SQLAlchemy URL above to connect to your Snowflake database
2. Use the Security JSON configuration for authentication
3. The private key is already formatted with escaped newlines for direct use
