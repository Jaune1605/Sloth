from pysnmp.hlapi import getCmd, SnmpEngine, CommunityData, UdpTransportTarget, ContextData, ObjectType, ObjectIdentity
from fastapi import FastAPI, HTTPException

app = FastAPI()

def snmp_get(target, oid, community='slothIT', port=161, engine=SnmpEngine()):

    errorIndication, errorStatus, errorIndex, varBinds = next(
        getCmd(engine,
               CommunityData(community, mpModel=0),
               UdpTransportTarget((target, port)),
               ContextData(),
               ObjectType(ObjectIdentity(oid)))
    )

    if errorIndication:
        print(errorIndication)
        raise HTTPException(status_code=500, detail=str(errorIndication))
    elif errorStatus:
        print(f"{errorStatus.prettyPrint()} at {errorIndex and varBinds[int(errorIndex) - 1][0] or '?'}")
        raise HTTPException(status_code=500, detail=f"{errorStatus.prettyPrint()} at {errorIndex and varBinds[int(errorIndex) - 1][0] or '?' }")
    else:
        for varBind in varBinds:
            return f"{varBind[0].prettyPrint()} = {varBind[1].prettyPrint()}"
