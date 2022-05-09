/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *UNISIM_P_0947159679;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *IEEE_P_3972351953;
char *WORK_P_0887726486;
char *IEEE_P_1242562249;
char *IEEE_P_0774719531;
char *STD_TEXTIO;
char *IEEE_P_3564397177;
char *IEEE_P_2717149903;
char *IEEE_P_1367372525;
char *UNISIM_P_3222816464;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_1242562249_init();
    ieee_p_3972351953_init();
    work_p_0887726486_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    unisim_p_0947159679_init();
    work_a_2470747995_1700962982_init();
    work_a_1365078297_1843827501_init();
    ieee_p_0774719531_init();
    std_textio_init();
    ieee_p_3564397177_init();
    ieee_p_2717149903_init();
    ieee_p_1367372525_init();
    unisim_p_3222816464_init();
    unisim_a_3107786922_1501512296_init();
    work_a_2935350621_3212880686_init();
    work_a_3761737140_3212880686_init();
    work_a_2185014878_3212880686_init();
    unisim_a_3994965186_1501512296_init();
    work_a_3212438184_3212880686_init();
    unisim_a_3447472048_1501512296_init();
    work_a_1948596493_3212880686_init();
    unisim_a_0793072792_1501512296_init();
    work_a_0420405532_3212880686_init();
    unisim_a_1340382728_1501512296_init();
    work_a_3528602297_3212880686_init();
    unisim_a_3717014088_1501512296_init();
    work_a_1414418859_3212880686_init();
    unisim_a_0109481924_1501512296_init();
    work_a_2668790286_3212880686_init();
    unisim_a_3326463593_1501512296_init();
    work_a_4063844895_3212880686_init();
    unisim_a_3781851907_1501512296_init();
    work_a_0962955706_3212880686_init();
    work_a_0409087883_3212880686_init();
    work_a_4201651659_3212880686_init();
    work_a_1949178628_2372691052_init();


    xsi_register_tops("work_a_1949178628_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_3972351953 = xsi_get_engine_memory("ieee_p_3972351953");
    WORK_P_0887726486 = xsi_get_engine_memory("work_p_0887726486");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    IEEE_P_0774719531 = xsi_get_engine_memory("ieee_p_0774719531");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");
    IEEE_P_2717149903 = xsi_get_engine_memory("ieee_p_2717149903");
    IEEE_P_1367372525 = xsi_get_engine_memory("ieee_p_1367372525");
    UNISIM_P_3222816464 = xsi_get_engine_memory("unisim_p_3222816464");

    return xsi_run_simulation(argc, argv);

}
