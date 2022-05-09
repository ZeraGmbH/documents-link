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

/* This file is designed for use with ISim build 0x8ef4fb42 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Anuja/FG_HW/Sequenzer.vhd";
extern char *WORK_P_0887726486;
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );


static void work_a_3761737140_3212880686_p_0(char *t0)
{
    char t49[16];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    int t16;
    int t17;
    unsigned int t18;
    int t19;
    int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    int t24;
    int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    int t36;
    int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    int t50;
    int t51;
    int t52;
    int t53;
    unsigned char t54;
    int t55;
    int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned char t60;
    unsigned char t61;
    unsigned char t62;
    int t63;
    int t64;
    int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    char *t69;
    char *t70;
    char *t71;
    char *t72;
    char *t73;
    static char *nl0[] = {&&LAB27, &&LAB28, &&LAB29};

LAB0:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 568U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 3252);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(86, ng0);
    t4 = (t0 + 2144U);
    t8 = *((char **)t4);
    t4 = (t0 + 684U);
    t9 = *((char **)t4);
    t10 = 1;
    if (12U == 12U)
        goto LAB11;

LAB12:    t10 = 0;

LAB13:    if ((!(t10)) != 0)
        goto LAB8;

LAB10:
LAB9:    xsi_set_current_line(139, ng0);
    t2 = ((WORK_P_0887726486) + 1420U);
    t4 = *((char **)t2);
    t16 = *((int *)t4);
    t17 = (t16 - 1);
    t2 = (t0 + 6308);
    *((int *)t2) = 0;
    t5 = (t0 + 6312);
    *((int *)t5) = t17;
    t19 = 0;
    t20 = t17;

LAB55:    if (t19 <= t20)
        goto LAB56;

LAB58:    goto LAB3;

LAB5:    t4 = (t0 + 592U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(87, ng0);
    t13 = (t0 + 684U);
    t14 = *((char **)t13);
    t13 = (t0 + 2144U);
    t15 = *((char **)t13);
    t13 = (t15 + 0);
    memcpy(t13, t14, 12U);
    xsi_set_current_line(89, ng0);
    t2 = (t0 + 684U);
    t4 = *((char **)t2);
    t2 = (t0 + 776U);
    t5 = *((char **)t2);
    t2 = ((WORK_P_0887726486) + 1012U);
    t8 = *((char **)t2);
    t16 = *((int *)t8);
    t17 = (t16 - 5);
    t11 = (t17 * -1);
    t18 = (t11 * 3U);
    t2 = (t0 + 1788U);
    t9 = *((char **)t2);
    t2 = ((WORK_P_0887726486) + 1012U);
    t12 = *((char **)t2);
    t19 = *((int *)t12);
    t20 = (t19 - 5);
    t21 = (t20 * -1);
    t22 = (4U * t21);
    t23 = (0 + t22);
    t2 = (t9 + t23);
    t24 = *((int *)t2);
    t25 = (t24 - 0);
    t26 = (t25 * 1);
    xsi_vhdl_check_range_of_index(0, 2, 1, t24);
    t27 = (t18 + t26);
    t28 = (12U * t27);
    t29 = (0 + t28);
    t13 = (t5 + t29);
    t1 = 1;
    if (12U == 12U)
        goto LAB20;

LAB21:    t1 = 0;

LAB22:    if (t1 != 0)
        goto LAB17;

LAB19:
LAB18:    goto LAB9;

LAB11:    t11 = 0;

LAB14:    if (t11 < 12U)
        goto LAB15;
    else
        goto LAB13;

LAB15:    t4 = (t8 + t11);
    t12 = (t9 + t11);
    if (*((unsigned char *)t4) != *((unsigned char *)t12))
        goto LAB12;

LAB16:    t11 = (t11 + 1);
    goto LAB14;

LAB17:    xsi_set_current_line(92, ng0);
    t31 = (t0 + 1512U);
    t32 = *((char **)t31);
    t3 = *((unsigned char *)t32);
    t31 = (char *)((nl0) + t3);
    goto **((char **)t31);

LAB20:    t30 = 0;

LAB23:    if (t30 < 12U)
        goto LAB24;
    else
        goto LAB22;

LAB24:    t14 = (t4 + t30);
    t15 = (t13 + t30);
    if (*((unsigned char *)t14) != *((unsigned char *)t15))
        goto LAB21;

LAB25:    t30 = (t30 + 1);
    goto LAB23;

LAB26:    goto LAB18;

LAB27:    xsi_set_current_line(95, ng0);
    t33 = (t0 + 1144U);
    t34 = *((char **)t33);
    t33 = ((WORK_P_0887726486) + 2508U);
    t35 = *((char **)t33);
    t36 = *((int *)t35);
    t37 = (t36 - 15);
    t38 = (t37 * -1);
    t39 = (1U * t38);
    t40 = (0 + t39);
    t33 = (t34 + t40);
    t6 = *((unsigned char *)t33);
    t41 = ((WORK_P_0887726486) + 808U);
    t42 = *((char **)t41);
    t7 = *((unsigned char *)t42);
    t10 = (t6 == t7);
    if (t10 != 0)
        goto LAB31;

LAB33:
LAB32:    goto LAB26;

LAB28:    xsi_set_current_line(102, ng0);
    t2 = (t0 + 1144U);
    t4 = *((char **)t2);
    t2 = ((WORK_P_0887726486) + 2508U);
    t5 = *((char **)t2);
    t16 = *((int *)t5);
    t17 = (t16 - 15);
    t11 = (t17 * -1);
    t18 = (1U * t11);
    t21 = (0 + t18);
    t2 = (t4 + t21);
    t1 = *((unsigned char *)t2);
    t8 = ((WORK_P_0887726486) + 740U);
    t9 = *((char **)t8);
    t3 = *((unsigned char *)t9);
    t6 = (t1 == t3);
    if (t6 != 0)
        goto LAB34;

LAB36:    xsi_set_current_line(107, ng0);
    t2 = (t0 + 1696U);
    t4 = *((char **)t2);
    t2 = (t0 + 1236U);
    t5 = *((char **)t2);
    t1 = 1;
    if (14U == 14U)
        goto LAB40;

LAB41:    t1 = 0;

LAB42:    if (t1 != 0)
        goto LAB37;

LAB39:    xsi_set_current_line(115, ng0);
    t2 = (t0 + 1696U);
    t4 = *((char **)t2);
    t2 = (t0 + 5856U);
    t5 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t49, t4, t2, 1);
    t8 = (t0 + 3312);
    t9 = (t8 + 32U);
    t12 = *((char **)t9);
    t13 = (t12 + 40U);
    t14 = *((char **)t13);
    memcpy(t14, t5, 14U);
    xsi_driver_first_trans_fast(t8);

LAB38:
LAB35:    goto LAB26;

LAB29:    xsi_set_current_line(120, ng0);
    t2 = (t0 + 1144U);
    t4 = *((char **)t2);
    t2 = ((WORK_P_0887726486) + 2508U);
    t5 = *((char **)t2);
    t16 = *((int *)t5);
    t17 = (t16 - 15);
    t11 = (t17 * -1);
    t18 = (1U * t11);
    t21 = (0 + t18);
    t2 = (t4 + t21);
    t1 = *((unsigned char *)t2);
    t8 = ((WORK_P_0887726486) + 740U);
    t9 = *((char **)t8);
    t3 = *((unsigned char *)t9);
    t6 = (t1 == t3);
    if (t6 != 0)
        goto LAB49;

LAB51:    xsi_set_current_line(125, ng0);
    t2 = (t0 + 1144U);
    t4 = *((char **)t2);
    t2 = ((WORK_P_0887726486) + 2644U);
    t5 = *((char **)t2);
    t16 = *((int *)t5);
    t17 = (t16 - 15);
    t11 = (t17 * -1);
    t18 = (1U * t11);
    t21 = (0 + t18);
    t2 = (t4 + t21);
    t1 = *((unsigned char *)t2);
    t8 = ((WORK_P_0887726486) + 1760U);
    t9 = *((char **)t8);
    t3 = *((unsigned char *)t9);
    t6 = (t1 == t3);
    if (t6 != 0)
        goto LAB52;

LAB54:
LAB53:
LAB50:    goto LAB26;

LAB30:    goto LAB26;

LAB31:    xsi_set_current_line(96, ng0);
    t41 = xsi_get_transient_memory(14U);
    memset(t41, 0, 14U);
    t43 = t41;
    memset(t43, (unsigned char)2, 14U);
    t44 = (t0 + 3312);
    t45 = (t44 + 32U);
    t46 = *((char **)t45);
    t47 = (t46 + 40U);
    t48 = *((char **)t47);
    memcpy(t48, t41, 14U);
    xsi_driver_first_trans_fast(t44);
    xsi_set_current_line(97, ng0);
    t2 = (t0 + 2212U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)1;
    xsi_set_current_line(98, ng0);
    t2 = (t0 + 3348);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)1;
    xsi_driver_first_trans_fast(t2);
    goto LAB32;

LAB34:    xsi_set_current_line(103, ng0);
    t8 = xsi_get_transient_memory(14U);
    memset(t8, 0, 14U);
    t12 = t8;
    memset(t12, (unsigned char)2, 14U);
    t13 = (t0 + 3312);
    t14 = (t13 + 32U);
    t15 = *((char **)t14);
    t31 = (t15 + 40U);
    t32 = *((char **)t31);
    memcpy(t32, t8, 14U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(104, ng0);
    t2 = (t0 + 2212U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)0;
    xsi_set_current_line(105, ng0);
    t2 = (t0 + 3348);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)0;
    xsi_driver_first_trans_fast(t2);
    goto LAB35;

LAB37:    xsi_set_current_line(108, ng0);
    t9 = (t0 + 1144U);
    t12 = *((char **)t9);
    t9 = ((WORK_P_0887726486) + 2644U);
    t13 = *((char **)t9);
    t16 = *((int *)t13);
    t17 = (t16 - 15);
    t18 = (t17 * -1);
    t21 = (1U * t18);
    t22 = (0 + t21);
    t9 = (t12 + t22);
    t3 = *((unsigned char *)t9);
    t14 = ((WORK_P_0887726486) + 1760U);
    t15 = *((char **)t14);
    t6 = *((unsigned char *)t15);
    t7 = (t3 == t6);
    if (t7 != 0)
        goto LAB46;

LAB48:    xsi_set_current_line(111, ng0);
    t2 = (t0 + 2212U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)0;
    xsi_set_current_line(112, ng0);
    t2 = (t0 + 3348);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);

LAB47:    goto LAB38;

LAB40:    t11 = 0;

LAB43:    if (t11 < 14U)
        goto LAB44;
    else
        goto LAB42;

LAB44:    t2 = (t4 + t11);
    t8 = (t5 + t11);
    if (*((unsigned char *)t2) != *((unsigned char *)t8))
        goto LAB41;

LAB45:    t11 = (t11 + 1);
    goto LAB43;

LAB46:    xsi_set_current_line(109, ng0);
    t14 = xsi_get_transient_memory(14U);
    memset(t14, 0, 14U);
    t31 = t14;
    memset(t31, (unsigned char)2, 14U);
    t32 = (t0 + 3312);
    t33 = (t32 + 32U);
    t34 = *((char **)t33);
    t35 = (t34 + 40U);
    t41 = *((char **)t35);
    memcpy(t41, t14, 14U);
    xsi_driver_first_trans_fast(t32);
    goto LAB47;

LAB49:    xsi_set_current_line(121, ng0);
    t8 = xsi_get_transient_memory(14U);
    memset(t8, 0, 14U);
    t12 = t8;
    memset(t12, (unsigned char)2, 14U);
    t13 = (t0 + 3312);
    t14 = (t13 + 32U);
    t15 = *((char **)t14);
    t31 = (t15 + 40U);
    t32 = *((char **)t31);
    memcpy(t32, t8, 14U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(122, ng0);
    t2 = (t0 + 2212U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)0;
    xsi_set_current_line(123, ng0);
    t2 = (t0 + 3348);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)0;
    xsi_driver_first_trans_fast(t2);
    goto LAB50;

LAB52:    xsi_set_current_line(126, ng0);
    t8 = xsi_get_transient_memory(14U);
    memset(t8, 0, 14U);
    t12 = t8;
    memset(t12, (unsigned char)2, 14U);
    t13 = (t0 + 3312);
    t14 = (t13 + 32U);
    t15 = *((char **)t14);
    t31 = (t15 + 40U);
    t32 = *((char **)t31);
    memcpy(t32, t8, 14U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(127, ng0);
    t2 = (t0 + 2212U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)1;
    xsi_set_current_line(128, ng0);
    t2 = (t0 + 3348);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)1;
    xsi_driver_first_trans_fast(t2);
    goto LAB53;

LAB56:    xsi_set_current_line(141, ng0);
    t8 = (t0 + 2144U);
    t9 = *((char **)t8);
    t8 = (t0 + 776U);
    t12 = *((char **)t8);
    t8 = (t0 + 6308);
    t24 = *((int *)t8);
    t25 = (t24 - 5);
    t11 = (t25 * -1);
    xsi_vhdl_check_range_of_index(5, 0, -1, *((int *)t8));
    t18 = (t11 * 3U);
    t13 = (t0 + 1788U);
    t14 = *((char **)t13);
    t13 = (t0 + 6308);
    t36 = *((int *)t13);
    t37 = (t36 - 5);
    t21 = (t37 * -1);
    xsi_vhdl_check_range_of_index(5, 0, -1, *((int *)t13));
    t22 = (4U * t21);
    t23 = (0 + t22);
    t15 = (t14 + t23);
    t50 = *((int *)t15);
    t51 = (t50 - 0);
    t26 = (t51 * 1);
    xsi_vhdl_check_range_of_index(0, 2, 1, t50);
    t27 = (t18 + t26);
    t28 = (12U * t27);
    t29 = (0 + t28);
    t31 = (t12 + t29);
    t1 = 1;
    if (12U == 12U)
        goto LAB62;

LAB63:    t1 = 0;

LAB64:    if (t1 != 0)
        goto LAB59;

LAB61:
LAB60:
LAB57:    t2 = (t0 + 6308);
    t19 = *((int *)t2);
    t4 = (t0 + 6312);
    t20 = *((int *)t4);
    if (t19 == t20)
        goto LAB58;

LAB86:    t16 = (t19 + 1);
    t19 = t16;
    t5 = (t0 + 6308);
    *((int *)t5) = t19;
    goto LAB55;

LAB59:    xsi_set_current_line(143, ng0);
    t34 = (t0 + 2212U);
    t35 = *((char **)t34);
    t6 = *((unsigned char *)t35);
    t7 = (t6 == (unsigned char)0);
    if (t7 == 1)
        goto LAB71;

LAB72:    t34 = (t0 + 1328U);
    t41 = *((char **)t34);
    t34 = (t0 + 6308);
    t52 = *((int *)t34);
    t53 = (t52 - 15);
    t38 = (t53 * -1);
    xsi_vhdl_check_range_of_index(15, 0, -1, *((int *)t34));
    t39 = (1U * t38);
    t40 = (0 + t39);
    t42 = (t41 + t40);
    t10 = *((unsigned char *)t42);
    t54 = (t10 == (unsigned char)2);
    t3 = t54;

LAB73:    if (t3 != 0)
        goto LAB68;

LAB70:    xsi_set_current_line(152, ng0);
    t2 = (t0 + 1144U);
    t4 = *((char **)t2);
    t2 = ((WORK_P_0887726486) + 2712U);
    t5 = *((char **)t2);
    t16 = *((int *)t5);
    t17 = (t16 - 15);
    t11 = (t17 * -1);
    t18 = (1U * t11);
    t21 = (0 + t18);
    t2 = (t4 + t21);
    t1 = *((unsigned char *)t2);
    t8 = ((WORK_P_0887726486) + 1896U);
    t9 = *((char **)t8);
    t3 = *((unsigned char *)t9);
    t6 = (t1 == t3);
    if (t6 != 0)
        goto LAB77;

LAB79:    xsi_set_current_line(159, ng0);
    t2 = (t0 + 1604U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t2 = ((WORK_P_0887726486) + 1488U);
    t5 = *((char **)t2);
    t3 = *((unsigned char *)t5);
    t6 = (t1 == t3);
    if (t6 != 0)
        goto LAB83;

LAB85:    xsi_set_current_line(162, ng0);
    t2 = ((WORK_P_0887726486) + 2304U);
    t4 = *((char **)t2);
    t16 = *((int *)t4);
    t2 = (t0 + 6308);
    t17 = *((int *)t2);
    t24 = (t17 - 5);
    t11 = (t24 * -1);
    t18 = (1 * t11);
    t21 = (0U + t18);
    t5 = (t0 + 3384);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t12 = (t9 + 40U);
    t13 = *((char **)t12);
    *((int *)t13) = t16;
    xsi_driver_first_trans_delta(t5, t21, 1, 0LL);

LAB84:
LAB78:
LAB69:    goto LAB60;

LAB62:    t30 = 0;

LAB65:    if (t30 < 12U)
        goto LAB66;
    else
        goto LAB64;

LAB66:    t32 = (t9 + t30);
    t33 = (t31 + t30);
    if (*((unsigned char *)t32) != *((unsigned char *)t33))
        goto LAB63;

LAB67:    t30 = (t30 + 1);
    goto LAB65;

LAB68:    xsi_set_current_line(145, ng0);
    t43 = (t0 + 1144U);
    t44 = *((char **)t43);
    t43 = ((WORK_P_0887726486) + 2848U);
    t45 = *((char **)t43);
    t55 = *((int *)t45);
    t56 = (t55 - 15);
    t57 = (t56 * -1);
    t58 = (1U * t57);
    t59 = (0 + t58);
    t43 = (t44 + t59);
    t60 = *((unsigned char *)t43);
    t46 = ((WORK_P_0887726486) + 1488U);
    t47 = *((char **)t46);
    t61 = *((unsigned char *)t47);
    t62 = (t60 == t61);
    if (t62 != 0)
        goto LAB74;

LAB76:    xsi_set_current_line(148, ng0);
    t2 = ((WORK_P_0887726486) + 2440U);
    t4 = *((char **)t2);
    t16 = *((int *)t4);
    t2 = (t0 + 6308);
    t17 = *((int *)t2);
    t24 = (t17 - 5);
    t11 = (t24 * -1);
    t18 = (1 * t11);
    t21 = (0U + t18);
    t5 = (t0 + 3384);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t12 = (t9 + 40U);
    t13 = *((char **)t12);
    *((int *)t13) = t16;
    xsi_driver_first_trans_delta(t5, t21, 1, 0LL);

LAB75:    goto LAB69;

LAB71:    t3 = (unsigned char)1;
    goto LAB73;

LAB74:    xsi_set_current_line(146, ng0);
    t46 = ((WORK_P_0887726486) + 2372U);
    t48 = *((char **)t46);
    t63 = *((int *)t48);
    t46 = (t0 + 6308);
    t64 = *((int *)t46);
    t65 = (t64 - 5);
    t66 = (t65 * -1);
    t67 = (1 * t66);
    t68 = (0U + t67);
    t69 = (t0 + 3384);
    t70 = (t69 + 32U);
    t71 = *((char **)t70);
    t72 = (t71 + 40U);
    t73 = *((char **)t72);
    *((int *)t73) = t63;
    xsi_driver_first_trans_delta(t69, t68, 1, 0LL);
    goto LAB75;

LAB77:    xsi_set_current_line(153, ng0);
    t8 = (t0 + 1604U);
    t12 = *((char **)t8);
    t7 = *((unsigned char *)t12);
    t8 = ((WORK_P_0887726486) + 1488U);
    t13 = *((char **)t8);
    t10 = *((unsigned char *)t13);
    t54 = (t7 == t10);
    if (t54 != 0)
        goto LAB80;

LAB82:    xsi_set_current_line(156, ng0);
    t2 = ((WORK_P_0887726486) + 2440U);
    t4 = *((char **)t2);
    t16 = *((int *)t4);
    t2 = (t0 + 6308);
    t17 = *((int *)t2);
    t24 = (t17 - 5);
    t11 = (t24 * -1);
    t18 = (1 * t11);
    t21 = (0U + t18);
    t5 = (t0 + 3384);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t12 = (t9 + 40U);
    t13 = *((char **)t12);
    *((int *)t13) = t16;
    xsi_driver_first_trans_delta(t5, t21, 1, 0LL);

LAB81:    goto LAB78;

LAB80:    xsi_set_current_line(154, ng0);
    t8 = ((WORK_P_0887726486) + 2372U);
    t14 = *((char **)t8);
    t24 = *((int *)t14);
    t8 = (t0 + 6308);
    t25 = *((int *)t8);
    t36 = (t25 - 5);
    t22 = (t36 * -1);
    t23 = (1 * t22);
    t26 = (0U + t23);
    t15 = (t0 + 3384);
    t31 = (t15 + 32U);
    t32 = *((char **)t31);
    t33 = (t32 + 40U);
    t34 = *((char **)t33);
    *((int *)t34) = t24;
    xsi_driver_first_trans_delta(t15, t26, 1, 0LL);
    goto LAB81;

LAB83:    xsi_set_current_line(160, ng0);
    t2 = ((WORK_P_0887726486) + 2372U);
    t8 = *((char **)t2);
    t16 = *((int *)t8);
    t2 = (t0 + 6308);
    t17 = *((int *)t2);
    t24 = (t17 - 5);
    t11 = (t24 * -1);
    t18 = (1 * t11);
    t21 = (0U + t18);
    t9 = (t0 + 3384);
    t12 = (t9 + 32U);
    t13 = *((char **)t12);
    t14 = (t13 + 40U);
    t15 = *((char **)t14);
    *((int *)t15) = t16;
    xsi_driver_first_trans_delta(t9, t21, 1, 0LL);
    goto LAB84;

}

static void work_a_3761737140_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(175, ng0);

LAB3:    t1 = (t0 + 1788U);
    t2 = *((char **)t1);
    t1 = (t0 + 3420);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 40U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 24U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3260);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3761737140_3212880686_p_2(char *t0)
{
    char t9[16];
    char t11[16];
    char t16[16];
    char *t1;
    char *t2;
    unsigned int t3;
    unsigned int t4;
    unsigned int t5;
    char *t6;
    char *t8;
    char *t10;
    char *t12;
    char *t13;
    int t14;
    unsigned int t15;
    char *t17;
    int t18;
    unsigned char t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    xsi_set_current_line(73, ng0);

LAB3:    t1 = (t0 + 960U);
    t2 = *((char **)t1);
    t3 = (19 - 8);
    t4 = (t3 * 1U);
    t5 = (0 + t4);
    t1 = (t2 + t5);
    t6 = (t0 + 6316);
    t10 = ((IEEE_P_2592010699) + 2332);
    t12 = (t11 + 0U);
    t13 = (t12 + 0U);
    *((int *)t13) = 8;
    t13 = (t12 + 4U);
    *((int *)t13) = 0;
    t13 = (t12 + 8U);
    *((int *)t13) = -1;
    t14 = (0 - 8);
    t15 = (t14 * -1);
    t15 = (t15 + 1);
    t13 = (t12 + 12U);
    *((unsigned int *)t13) = t15;
    t13 = (t16 + 0U);
    t17 = (t13 + 0U);
    *((int *)t17) = 0;
    t17 = (t13 + 4U);
    *((int *)t17) = 4;
    t17 = (t13 + 8U);
    *((int *)t17) = 1;
    t18 = (4 - 0);
    t15 = (t18 * 1);
    t15 = (t15 + 1);
    t17 = (t13 + 12U);
    *((unsigned int *)t17) = t15;
    t8 = xsi_base_array_concat(t8, t9, t10, (char)97, t1, t11, (char)97, t6, t16, (char)101);
    t15 = (9U + 5U);
    t19 = (14U != t15);
    if (t19 == 1)
        goto LAB5;

LAB6:    t17 = (t0 + 3456);
    t20 = (t17 + 32U);
    t21 = *((char **)t20);
    t22 = (t21 + 40U);
    t23 = *((char **)t22);
    memcpy(t23, t8, 14U);
    xsi_driver_first_trans_fast(t17);

LAB2:    t24 = (t0 + 3268);
    *((int *)t24) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(14U, t15, 0);
    goto LAB6;

}


extern void work_a_3761737140_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3761737140_3212880686_p_0,(void *)work_a_3761737140_3212880686_p_1,(void *)work_a_3761737140_3212880686_p_2};
	xsi_register_didat("work_a_3761737140_3212880686", "isim/testbench_isim_beh.exe.sim/work/a_3761737140_3212880686.didat");
	xsi_register_executes(pe);
}
