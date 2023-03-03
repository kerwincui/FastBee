
#if !defined(MQTTETHERNET_H)
#define MQTTETHERNET_H

#include "MQTTmbed.h"
#include "EthernetInterface.h"
#include "MQTTSocket.h"

class MQTTEthernet : public MQTTSocket
{
public:    
    MQTTEthernet() : MQTTSocket(&eth)
    {
        eth.connect();
    }
    
    EthernetInterface& getEth()
    {
        return eth;
    }
    
private:

    EthernetInterface eth;
    
};


#endif
