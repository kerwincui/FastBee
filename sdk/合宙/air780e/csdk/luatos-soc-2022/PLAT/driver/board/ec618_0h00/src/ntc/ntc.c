/****************************************************************************
 *
 * Copy right:   2018 Copyrigths of AirM2M Ltd.
 * File name:    ntc.c
 * Description:
 * History:
 *
 ****************************************************************************/
#include <stdint.h>
#include "ntc.h"

#define NCP15XH103F03RC

#if defined(NCP15XH103F03RC)
static const int32_t gNTCLut[65] = {
    253347,     // T:253.35 Rntc:0.0k       ADC code:0      Input voltage:0uV
    187444,     // T:187.44 Rntc:0.159k     ADC code:64     Input voltage:18750uV
    149195,     // T:149.2  Rntc:0.323k     ADC code:128    Input voltage:37500uV
    128368,     // T:128.37 Rntc:0.492k     ADC code:192    Input voltage:56250uV
    115301,     // T:115.3  Rntc:0.667k     ADC code:256    Input voltage:75000uV
    105493,     // T:105.49 Rntc:0.847k     ADC code:320    Input voltage:93750uV
    97670,      // T:97.67  Rntc:1.034k     ADC code:384    Input voltage:112500uV
    91187,      // T:91.19  Rntc:1.228k     ADC code:448    Input voltage:131250uV
    85596,      // T:85.6   Rntc:1.429k     ADC code:512    Input voltage:150000uV
    80693,      // T:80.69  Rntc:1.636k     ADC code:576    Input voltage:168750uV
    76336,      // T:76.34  Rntc:1.852k     ADC code:640    Input voltage:187500uV
    72403,      // T:72.4   Rntc:2.075k     ADC code:704    Input voltage:206250uV
    68803,      // T:68.8   Rntc:2.308k     ADC code:768    Input voltage:225000uV
    65478,      // T:65.48  Rntc:2.549k     ADC code:832    Input voltage:243750uV
    62389,      // T:62.39  Rntc:2.8k       ADC code:896    Input voltage:262500uV
    59508,      // T:59.51  Rntc:3.061k     ADC code:960    Input voltage:281250uV
    56829,      // T:56.83  Rntc:3.333k     ADC code:1024   Input voltage:300000uV
    54289,      // T:54.29  Rntc:3.617k     ADC code:1088   Input voltage:318750uV
    51869,      // T:51.87  Rntc:3.913k     ADC code:1152   Input voltage:337500uV
    49556,      // T:49.56  Rntc:4.222k     ADC code:1216   Input voltage:356250uV
    47337,      // T:47.34  Rntc:4.545k     ADC code:1280   Input voltage:375000uV
    45200,      // T:45.2   Rntc:4.884k     ADC code:1344   Input voltage:393750uV
    43135,      // T:43.14  Rntc:5.238k     ADC code:1408   Input voltage:412500uV
    41134,      // T:41.13  Rntc:5.61k      ADC code:1472   Input voltage:431250uV
    39186,      // T:39.19  Rntc:6.0k       ADC code:1536   Input voltage:450000uV
    37287,      // T:37.29  Rntc:6.41k      ADC code:1600   Input voltage:468750uV
    35433,      // T:35.43  Rntc:6.842k     ADC code:1664   Input voltage:487500uV
    33620,      // T:33.62  Rntc:7.297k     ADC code:1728   Input voltage:506250uV
    31842,      // T:31.84  Rntc:7.778k     ADC code:1792   Input voltage:525000uV
    30095,      // T:30.1   Rntc:8.286k     ADC code:1856   Input voltage:543750uV
    28377,      // T:28.38  Rntc:8.824k     ADC code:1920   Input voltage:562500uV
    26680,      // T:26.68  Rntc:9.394k     ADC code:1984   Input voltage:581250uV
    25000,      // T:25.0   Rntc:10.0k      ADC code:2048   Input voltage:600000uV
    23332,      // T:23.33  Rntc:10.645k    ADC code:2112   Input voltage:618750uV
    21675,      // T:21.68  Rntc:11.333k    ADC code:2176   Input voltage:637500uV
    20024,      // T:20.02  Rntc:12.069k    ADC code:2240   Input voltage:656250uV
    18382,      // T:18.38  Rntc:12.857k    ADC code:2304   Input voltage:675000uV
    16741,      // T:16.74  Rntc:13.704k    ADC code:2368   Input voltage:693750uV
    15100,      // T:15.1   Rntc:14.615k    ADC code:2432   Input voltage:712500uV
    13455,      // T:13.46  Rntc:15.6k      ADC code:2496   Input voltage:731250uV
    11801,      // T:11.8   Rntc:16.667k    ADC code:2560   Input voltage:750000uV
    10137,      // T:10.14  Rntc:17.826k    ADC code:2624   Input voltage:768750uV
    8454,       // T:8.45   Rntc:19.091k    ADC code:2688   Input voltage:787500uV
    6750,       // T:6.75   Rntc:20.476k    ADC code:2752   Input voltage:806250uV
    5022,       // T:5.02   Rntc:22.0k      ADC code:2816   Input voltage:825000uV
    3265,       // T:3.27   Rntc:23.684k    ADC code:2880   Input voltage:843750uV
    1472,       // T:1.47   Rntc:25.556k    ADC code:2944   Input voltage:862500uV
    -361,       // T:-0.36  Rntc:27.647k    ADC code:3008   Input voltage:881250uV
    -2238,      // T:-2.24  Rntc:30.0k      ADC code:3072   Input voltage:900000uV
    -4171,      // T:-4.17  Rntc:32.667k    ADC code:3136   Input voltage:918750uV
    -6170,      // T:-6.17  Rntc:35.714k    ADC code:3200   Input voltage:937500uV
    -8248,      // T:-8.25  Rntc:39.231k    ADC code:3264   Input voltage:956250uV
    -10419,     // T:-10.42 Rntc:43.333k    ADC code:3328   Input voltage:975000uV
    -12711,     // T:-12.71 Rntc:48.182k    ADC code:3392   Input voltage:993750uV
    -15137,     // T:-15.14 Rntc:54.0k      ADC code:3456   Input voltage:1012500uV
    -17727,     // T:-17.73 Rntc:61.111k    ADC code:3520   Input voltage:1031250uV
    -20519,     // T:-20.52 Rntc:70.0k      ADC code:3584   Input voltage:1050000uV
    -23562,     // T:-23.56 Rntc:81.429k    ADC code:3648   Input voltage:1068750uV
    -26937,     // T:-26.94 Rntc:96.667k    ADC code:3712   Input voltage:1087500uV
    -30762,     // T:-30.76 Rntc:118.0k     ADC code:3776   Input voltage:1106250uV
    -35224,     // T:-35.22 Rntc:150.0k     ADC code:3840   Input voltage:1125000uV
    -40677,     // T:-40.68 Rntc:203.333k   ADC code:3904   Input voltage:1143750uV
    -47755,     // T:-47.76 Rntc:310.0k     ADC code:3968   Input voltage:1162500uV
    -57225,     // T:-57.23 Rntc:630.0k     ADC code:4032   Input voltage:1181250uV
    -69859,     // T:-69.86 Rntc:10000.0k   ADC code:4096   Input voltage:1200000uV
};
#elif defined(NCP15WF104F03RC)
static const int32_t gNTCLut[65] = {
    175093,     // T:175.09 Rntc:0.0k       ADC code:0  Input voltage:0uV
    140197,     // T:140.2  Rntc:1.587k     ADC code:64 Input voltage:18750uV
    116573,     // T:116.57 Rntc:3.226k     ADC code:128    Input voltage:37500uV
    102838,     // T:102.84 Rntc:4.918k     ADC code:192    Input voltage:56250uV
    93457,      // T:93.46  Rntc:6.667k     ADC code:256    Input voltage:75000uV
    86333,      // T:86.33  Rntc:8.475k     ADC code:320    Input voltage:93750uV
    80598,      // T:80.6   Rntc:10.345k    ADC code:384    Input voltage:112500uV
    75787,      // T:75.79  Rntc:12.281k    ADC code:448    Input voltage:131250uV
    71646,      // T:71.65  Rntc:14.286k    ADC code:512    Input voltage:150000uV
    67994,      // T:67.99  Rntc:16.364k    ADC code:576    Input voltage:168750uV
    64720,      // T:64.72  Rntc:18.519k    ADC code:640    Input voltage:187500uV
    61757,      // T:61.76  Rntc:20.755k    ADC code:704    Input voltage:206250uV
    59039,      // T:59.04  Rntc:23.077k    ADC code:768    Input voltage:225000uV
    56524,      // T:56.52  Rntc:25.49k     ADC code:832    Input voltage:243750uV
    54178,      // T:54.18  Rntc:28.0k      ADC code:896    Input voltage:262500uV
    51977,      // T:51.98  Rntc:30.612k    ADC code:960    Input voltage:281250uV
    49898,      // T:49.9   Rntc:33.333k    ADC code:1024   Input voltage:300000uV
    47928,      // T:47.93  Rntc:36.17k     ADC code:1088   Input voltage:318750uV
    46050,      // T:46.05  Rntc:39.13k     ADC code:1152   Input voltage:337500uV
    44250,      // T:44.25  Rntc:42.222k    ADC code:1216   Input voltage:356250uV
    42521,      // T:42.52  Rntc:45.455k    ADC code:1280   Input voltage:375000uV
    40853,      // T:40.85  Rntc:48.837k    ADC code:1344   Input voltage:393750uV
    39240,      // T:39.24  Rntc:52.381k    ADC code:1408   Input voltage:412500uV
    37676,      // T:37.68  Rntc:56.098k    ADC code:1472   Input voltage:431250uV
    36155,      // T:36.16  Rntc:60.0k      ADC code:1536   Input voltage:450000uV
    34671,      // T:34.67  Rntc:64.103k    ADC code:1600   Input voltage:468750uV
    33220,      // T:33.22  Rntc:68.421k    ADC code:1664   Input voltage:487500uV
    31797,      // T:31.8   Rntc:72.973k    ADC code:1728   Input voltage:506250uV
    30400,      // T:30.4   Rntc:77.778k    ADC code:1792   Input voltage:525000uV
    29025,      // T:29.03  Rntc:82.857k    ADC code:1856   Input voltage:543750uV
    27669,      // T:27.67  Rntc:88.235k    ADC code:1920   Input voltage:562500uV
    26328,      // T:26.33  Rntc:93.939k    ADC code:1984   Input voltage:581250uV
    24999,      // T:25.0   Rntc:100.0k     ADC code:2048   Input voltage:600000uV
    23681,      // T:23.68  Rntc:106.452k   ADC code:2112   Input voltage:618750uV
    22370,      // T:22.37  Rntc:113.333k   ADC code:2176   Input voltage:637500uV
    21064,      // T:21.06  Rntc:120.69k    ADC code:2240   Input voltage:656250uV
    19760,      // T:19.76  Rntc:128.571k   ADC code:2304   Input voltage:675000uV
    18455,      // T:18.46  Rntc:137.037k   ADC code:2368   Input voltage:693750uV
    17148,      // T:17.15  Rntc:146.154k   ADC code:2432   Input voltage:712500uV
    15835,      // T:15.84  Rntc:156.0k     ADC code:2496   Input voltage:731250uV
    14513,      // T:14.51  Rntc:166.667k   ADC code:2560   Input voltage:750000uV
    13179,      // T:13.18  Rntc:178.261k   ADC code:2624   Input voltage:768750uV
    11830,      // T:11.83  Rntc:190.909k   ADC code:2688   Input voltage:787500uV
    10463,      // T:10.46  Rntc:204.762k   ADC code:2752   Input voltage:806250uV
    9074,       // T:9.07   Rntc:220.0k     ADC code:2816   Input voltage:825000uV
    7658,       // T:7.66   Rntc:236.842k   ADC code:2880   Input voltage:843750uV
    6211,       // T:6.21   Rntc:255.556k   ADC code:2944   Input voltage:862500uV
    4728,       // T:4.73   Rntc:276.471k   ADC code:3008   Input voltage:881250uV
    3202,       // T:3.2    Rntc:300.0k     ADC code:3072   Input voltage:900000uV
    1626,       // T:1.63   Rntc:326.667k   ADC code:3136   Input voltage:918750uV
    -6,         // T:-0.01  Rntc:357.143k   ADC code:3200   Input voltage:937500uV
    -1710,      // T:-1.71  Rntc:392.308k   ADC code:3264   Input voltage:956250uV
    -3495,      // T:-3.5   Rntc:433.333k   ADC code:3328   Input voltage:975000uV
    -5376,      // T:-5.38  Rntc:481.818k   ADC code:3392   Input voltage:993750uV
    -7371,      // T:-7.37  Rntc:540.0k     ADC code:3456   Input voltage:1012500uV
    -9506,      // T:-9.51  Rntc:611.111k   ADC code:3520   Input voltage:1031250uV
    -11819,     // T:-11.82 Rntc:700.0k     ADC code:3584   Input voltage:1050000uV
    -14354,     // T:-14.35 Rntc:814.286k   ADC code:3648   Input voltage:1068750uV
    -17179,     // T:-17.18 Rntc:966.667k   ADC code:3712   Input voltage:1087500uV
    -20397,     // T:-20.4  Rntc:1180.0k    ADC code:3776   Input voltage:1106250uV
    -24176,     // T:-24.18 Rntc:1500.0k    ADC code:3840   Input voltage:1125000uV
    -28836,     // T:-28.84 Rntc:2033.333k  ADC code:3904   Input voltage:1143750uV
    -35053,     // T:-35.05 Rntc:3100.0k    ADC code:3968   Input voltage:1162500uV
    -44840,     // T:-44.84 Rntc:6300.0k    ADC code:4032   Input voltage:1181250uV
    -63302,     // T:-63.3  Rntc:100000.0k  ADC code:4096   Input voltage:1200000uV
};

#else
#error "NTC type is not defined"
#endif


int32_t ntcGetTemperature(int32_t adcInputVoltage)
{
    if(adcInputVoltage <= 1200000)
    {
        int32_t step = 1200000 >> 6;
        int32_t i = adcInputVoltage / step;
        return gNTCLut[i] + ((int32_t)((gNTCLut[i + 1] - gNTCLut[i]) * (adcInputVoltage - (i * step))) / step);
    }
    else
    {
        return -256000;
    }
}


