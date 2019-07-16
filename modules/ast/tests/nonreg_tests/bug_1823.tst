// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - DIGITEO - Bruno JOFRET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for bug 1823 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=1823
//
// <-- Short Description -->
// Having very long instruction make scilab parser crash.

// <-- CLI SHELL MODE -->

function Xdot = simul(t, X,t1)
    //**************************************
    //****************************Estimated parameters************************************
    mu_max=0.069917;
    k_S=1.607530;
    k_O=3.14E-02;
    k_SP=177.073574;
    k_i=2.43E-01;
    Y_xD=1.36E+00;
    Y_pD=0.090963;
    m_D=1.44E-06;
    Y_xO = 1.80;
    Y_OP= 2.38E+00;
    pi_max=3.88E-02;
    s_in=600;
    kdx=0.001;
    kdp=2.20E-04;

    f_max=190;

    x1=X(1);
    x2=X(2);
    x3=X(3);
    x4=X(4);
    mu_D=mu_max*x2/(k_S*x1+x2);
    pi_R=(x2*x4)/(k_SP*x4^2 + x2*x4 + k_i*x2^2);
    sigma_D=mu_D/Y_xD + pi_R/Y_pD + m_D;
    if t<15*3600
        mu_D=0; // mu_D=0 for the first 15 hours
    end;

    if t<t1*3600 then,
        fin=0;
    else,
        NFs=(1/3600*x1*(mu_max/(x2 + k_S*x1) - x2*mu_max/(x2 +k_S*x1)^2)*(1/12960000*x1*(x2/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) -x2*x4/Y_pD*(x2 + 2*x4*k_SP)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2) +1/12960000*x1*s_in*(x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) + 1/Y_xD*mu_max/(x2 +k_S*x1) - x2/Y_xD*mu_max/(x2 + k_S*x1)^2 - x2*x4/Y_pD*(x4 + 2*k_i*x2)/(k_i*x2^2+ x2*x4 + k_SP*x4^2)^2)) - 1/3600*x1*(kdx - x2*mu_max/(x2 +k_S*x1))*(1/12960000*s_in*(mu_max/(x2 + k_S*x1) - x2*mu_max/(x2 + k_S*x1)^2) -1/12960000*x1*s_in*(k_S*mu_max/(x2 + k_S*x1)^2 - 2*k_S*x2*mu_max/(x2 +k_S*x1)^3)) + 1/12960000*x1*s_in*(mu_max/(x2 + k_S*x1) - x2*mu_max/(x2 +k_S*x1)^2)*(1/3600*kdx - 1/3600*x2*mu_max/(x2 + k_S*x1) +1/3600*k_S*x1*x2*mu_max/(x2 + k_S*x1)^2) + 1/46656000000*x1^2*s_in*(2*mu_max/(x2+ k_S*x1)^2 - 2*x2*mu_max/(x2 + k_S*x1)^3)*(m_D + x2*x4/Y_pD/(k_i*x2^2 + x2*x4 +k_SP*x4^2) + x2/Y_xD*mu_max/(x2 + k_S*x1)))/(k_i*kdx*x1*x2^5*Y_xD -k_i*x1*x2^5*Y_xD*mu_max + 2*k_S*k_i*kdx*x1^2*x2^4*Y_xD -kdx*x1*x2^3*x4^2*Y_xD*k_SP - k_S*k_i*x1^2*x2^4*Y_xD*mu_max +k_S^2*k_i*kdx*x1^3*x2^3*Y_xD + x1*x2^3*x4^2*Y_xD*k_SP*mu_max -k_i*kdx*x1*x2^4*x4*Y_xD*s_in - x1*x2^2*x4^3*Y_xD*k_SP*mu_max*s_in +k_S*x1^2*x2^2*x4^2*Y_xD*k_SP*mu_max + k_S^2*kdx*x1^3*x4^3*Y_xD*k_SP*s_in +k_S*x1^2*x2^2*x4^2*Y_xD*mu_max*s_in + k_i*x1*x2^4*x4*Y_xD*mu_max*s_in +kdx*x1*x2^2*x4^3*Y_xD*k_SP*s_in - 2*k_S*kdx*x1^2*x2^2*x4^2*Y_xD*k_SP -k_S^2*kdx*x1^3*x2*x4^2*Y_xD*k_SP - k_S^2*k_i*kdx*x1^3*x2^2*x4*Y_xD*s_in +k_S*k_i^2*kdx*x1^2*x2^4*Y_pD*mu_max*s_in +k_S*kdx*x1^2*x2^2*x4^2*Y_pD*mu_max*s_in - 2*k_S*k_i*kdx*x1^2*x2^3*x4*Y_xD*s_in +k_S*kdx*x1^2*x4^4*Y_pD*k_SP^2*mu_max*s_in +2*k_S*kdx*x1^2*x2*x4^3*Y_xD*k_SP*s_in + 2*k_S*k_i*x1^2*x2^3*x4*Y_xD*mu_max*s_in+ k_S*m_D*x1^2*x4^4*Y_pD*Y_xD*k_SP^2*mu_max*s_in +2*k_S*kdx*x1^2*x2*x4^3*Y_pD*k_SP*mu_max*s_in +k_S*k_i^2*m_D*x1^2*x2^4*Y_pD*Y_xD*mu_max*s_in +k_S*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*mu_max*s_in +2*k_S*k_i*kdx*x1^2*x2^3*x4*Y_pD*mu_max*s_in +2*k_S*k_i*m_D*x1^2*x2^3*x4*Y_pD*Y_xD*mu_max*s_in +2*k_S*m_D*x1^2*x2*x4^3*Y_pD*Y_xD*k_SP*mu_max*s_in +2*k_S*k_i*kdx*x1^2*x2^2*x4^2*Y_pD*k_SP*mu_max*s_in +2*k_S*k_i*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*k_SP*mu_max*s_in)*(12960000*x2^4*x4^2*Y_xD+ 12960000*x2^3*x4^3*Y_xD*k_SP + 12960000*k_i^2*x2^6*Y_pD*mu_max +12960000*x2^4*x4^2*Y_pD*mu_max + 12960000*k_i*x2^5*x4*Y_xD +12960000*k_S^2*x1^2*x2^2*x4^2*Y_xD + 25920000*k_i*x2^5*x4*Y_pD*mu_max +25920000*k_S*x1*x2^3*x4^2*Y_xD + 12960000*x2^2*x4^4*Y_pD*k_SP^2*mu_max +12960000*k_i^2*m_D*x2^6*Y_pD*Y_xD + 12960000*m_D*x2^4*x4^2*Y_pD*Y_xD +25920000*x2^3*x4^3*Y_pD*k_SP*mu_max + 12960000*m_D*x2^2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_S*x1*x2^2*x4^3*Y_xD*k_SP + 12960000*k_S*k_i^2*x1*x2^5*Y_pD*mu_max +12960000*k_S*x1*x2^3*x4^2*Y_pD*mu_max + 12960000*k_S^2*k_i*x1^2*x2^3*x4*Y_xD +25920000*k_S*k_i*x1*x2^4*x4*Y_xD + 25920000*m_D*x2^3*x4^3*Y_pD*Y_xD*k_SP +25920000*k_i*x2^4*x4^2*Y_pD*k_SP*mu_max + 12960000*k_S^2*x1^2*x2*x4^3*Y_xD*k_SP+ 25920000*k_i*m_D*x2^5*x4*Y_pD*Y_xD + 25920000*k_S*k_i*x1*x2^4*x4*Y_pD*mu_max +12960000*k_S^2*k_i^2*m_D*x1^2*x2^4*Y_pD*Y_xD +12960000*k_S^2*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD +25920000*k_S*k_i^2*m_D*x1*x2^5*Y_pD*Y_xD +25920000*k_S*m_D*x1*x2^3*x4^2*Y_pD*Y_xD +12960000*k_S^2*m_D*x1^2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_i*m_D*x2^4*x4^2*Y_pD*Y_xD*k_SP +25920000*k_S*x1*x2^2*x4^3*Y_pD*k_SP*mu_max +12960000*k_S*x1*x2*x4^4*Y_pD*k_SP^2*mu_max +25920000*k_S^2*m_D*x1^2*x2*x4^3*Y_pD*Y_xD*k_SP +51840000*k_S*m_D*x1*x2^2*x4^3*Y_pD*Y_xD*k_SP +25920000*k_S*m_D*x1*x2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_S^2*k_i*m_D*x1^2*x2^3*x4*Y_pD*Y_xD +25920000*k_S*k_i*x1*x2^3*x4^2*Y_pD*k_SP*mu_max +51840000*k_S*k_i*m_D*x1*x2^4*x4*Y_pD*Y_xD +25920000*k_S^2*k_i*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*k_SP +51840000*k_S*k_i*m_D*x1*x2^3*x4^2*Y_pD*Y_xD*k_SP) - (1/3600*x1*(kdx -x2*mu_max/(x2 + k_S*x1))*(1/12960000*s_in*(x4/Y_pD/(k_i*x2^2 + x2*x4 +k_SP*x4^2) + 1/Y_xD*mu_max/(x2 + k_S*x1) - x2/Y_xD*mu_max/(x2 + k_S*x1)^2 -x2*x4/Y_pD*(x4 + 2*k_i*x2)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2) +1/12960000*x2/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) -1/12960000*x1*s_in*(k_S/Y_xD*mu_max/(x2 + k_S*x1)^2 - 2*k_S*x2/Y_xD*mu_max/(x2 +k_S*x1)^3)+ - 1/12960000*x2*x4/Y_pD*(x2 + 2*x4*k_SP)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2) -1/3600*x1*(1/12960000*x1*(x2/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) -x2*x4/Y_pD*(x2 + 2*x4*k_SP)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2) +1/12960000*x1*s_in*(x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) + 1/Y_xD*mu_max/(x2 +k_S*x1) - x2/Y_xD*mu_max/(x2 + k_S*x1)^2 - x2*x4/Y_pD*(x4 + 2*k_i*x2)/(k_i*x2^2+ x2*x4 + k_SP*x4^2)^2))*(x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) +1/Y_xD*mu_max/(x2 + k_S*x1) - x2/Y_xD*mu_max/(x2 + k_S*x1)^2 - x2*x4/Y_pD*(x4 +2*k_i*x2)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2) -1/3600*x1*(1/12960000*x1*(x2*x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2 -1/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) + x4/Y_pD*(x2 + 2*x4*k_SP)/(k_i*x2^2 +x2*x4 + k_SP*x4^2)^2 + x2/Y_pD*(x4 + 2*k_i*x2)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2- 2*x2*x4/Y_pD*(x4 + 2*k_i*x2)*(x2 + 2*x4*k_SP)/(k_i*x2^2 + x2*x4 +k_SP*x4^2)^3) + 1/12960000*x1*s_in*(2/Y_xD*mu_max/(x2 + k_S*x1)^2 -2*x2/Y_xD*mu_max/(x2 + k_S*x1)^3 + 2*x4/Y_pD*(x4 + 2*k_i*x2)/(k_i*x2^2 + x2*x4 +k_SP*x4^2)^2 + 2*k_i*x2*x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2 -2*x2*x4/Y_pD*(x4 + 2*k_i*x2)^2/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^3))*(m_D +x2*x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) + x2/Y_xD*mu_max/(x2 + k_S*x1)) +1/12960000*x1*s_in*(mu_max/(x2 + k_S*x1) - x2*mu_max/(x2 +k_S*x1)^2)*(1/3600*m_D + 1/3600*x2*x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) +1/3600*x2/Y_xD*mu_max/(x2 + k_S*x1) - 1/3600*k_S*x1*x2/Y_xD*mu_max/(x2 +k_S*x1)^2))*(12960000*k_i^2*kdx*x2^6*Y_pD*Y_xD +12960000*kdx*x2^4*x4^2*Y_pD*Y_xD - 12960000*k_i^2*x2^6*Y_pD*Y_xD*mu_max -12960000*x2^4*x4^2*Y_pD*Y_xD*mu_max - 25920000*x2^3*x4^3*Y_pD*Y_xD*k_SP*mu_max +12960000*kdx*x2^2*x4^4*Y_pD*Y_xD*k_SP^2 - 25920000*k_i*x2^5*x4*Y_pD*Y_xD*mu_max- 12960000*x2^2*x4^4*Y_pD*Y_xD*k_SP^2*mu_max +25920000*kdx*x2^3*x4^3*Y_pD*Y_xD*k_SP + 25920000*k_i*kdx*x2^5*x4*Y_pD*Y_xD -25920000*k_i*x2^4*x4^2*Y_pD*Y_xD*k_SP*mu_max +12960000*k_S^2*k_i^2*kdx*x1^2*x2^4*Y_pD*Y_xD +12960000*k_S^2*kdx*x1^2*x2^2*x4^2*Y_pD*Y_xD +25920000*k_S*k_i^2*kdx*x1*x2^5*Y_pD*Y_xD+25920000*k_S*kdx*x1*x2^3*x4^2*Y_pD*Y_xD +12960000*k_S^2*kdx*x1^2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_i*kdx*x2^4*x4^2*Y_pD*Y_xD*k_SP -12960000*k_S*k_i^2*x1*x2^5*Y_pD*Y_xD*mu_max -12960000*k_S*x1*x2^3*x4^2*Y_pD*Y_xD*mu_max -25920000*k_S*x1*x2^2*x4^3*Y_pD*Y_xD*k_SP*mu_max -12960000*k_S*x1*x2*x4^4*Y_pD*Y_xD*k_SP^2*mu_max +25920000*k_S^2*kdx*x1^2*x2*x4^3*Y_pD*Y_xD*k_SP -25920000*k_S*k_i*x1*x2^4*x4*Y_pD*Y_xD*mu_max +51840000*k_S*kdx*x1*x2^2*x4^3*Y_pD*Y_xD*k_SP +25920000*k_S*kdx*x1*x2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_S^2*k_i*kdx*x1^2*x2^3*x4*Y_pD*Y_xD +51840000*k_S*k_i*kdx*x1*x2^4*x4*Y_pD*Y_xD -25920000*k_S*k_i*x1*x2^3*x4^2*Y_pD*Y_xD*k_SP*mu_max +25920000*k_S^2*k_i*kdx*x1^2*x2^2*x4^2*Y_pD*Y_xD*k_SP +51840000*k_S*k_i*kdx*x1*x2^3*x4^2*Y_pD*Y_xD*k_SP)/(k_i*kdx*x1*x2^5*Y_xD -k_i*x1*x2^5*Y_xD*mu_max + 2*k_S*k_i*kdx*x1^2*x2^4*Y_xD -kdx*x1*x2^3*x4^2*Y_xD*k_SP - k_S*k_i*x1^2*x2^4*Y_xD*mu_max +k_S^2*k_i*kdx*x1^3*x2^3*Y_xD + x1*x2^3*x4^2*Y_xD*k_SP*mu_max -k_i*kdx*x1*x2^4*x4*Y_xD*s_in - x1*x2^2*x4^3*Y_xD*k_SP*mu_max*s_in +k_S*x1^2*x2^2*x4^2*Y_xD*k_SP*mu_max + k_S^2*kdx*x1^3*x4^3*Y_xD*k_SP*s_in +k_S*x1^2*x2^2*x4^2*Y_xD*mu_max*s_in + k_i*x1*x2^4*x4*Y_xD*mu_max*s_in +kdx*x1*x2^2*x4^3*Y_xD*k_SP*s_in - 2*k_S*kdx*x1^2*x2^2*x4^2*Y_xD*k_SP -k_S^2*kdx*x1^3*x2*x4^2*Y_xD*k_SP - k_S^2*k_i*kdx*x1^3*x2^2*x4*Y_xD*s_in +k_S*k_i^2*kdx*x1^2*x2^4*Y_pD*mu_max*s_in +k_S*kdx*x1^2*x2^2*x4^2*Y_pD*mu_max*s_in - 2*k_S*k_i*kdx*x1^2*x2^3*x4*Y_xD*s_in +k_S*kdx*x1^2*x4^4*Y_pD*k_SP^2*mu_max*s_in +2*k_S*kdx*x1^2*x2*x4^3*Y_xD*k_SP*s_in + 2*k_S*k_i*x1^2*x2^3*x4*Y_xD*mu_max*s_in+ k_S*m_D*x1^2*x4^4*Y_pD*Y_xD*k_SP^2*mu_max*s_in +2*k_S*kdx*x1^2*x2*x4^3*Y_pD*k_SP*mu_max*s_in +k_S*k_i^2*m_D*x1^2*x2^4*Y_pD*Y_xD*mu_max*s_in +k_S*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*mu_max*s_in +2*k_S*k_i*kdx*x1^2*x2^3*x4*Y_pD*mu_max*s_in +2*k_S*k_i*m_D*x1^2*x2^3*x4*Y_pD*Y_xD*mu_max*s_in +2*k_S*m_D*x1^2*x2*x4^3*Y_pD*Y_xD*k_SP*mu_max*s_in +2*k_S*k_i*kdx*x1^2*x2^2*x4^2*Y_pD*k_SP*mu_max*s_in +2*k_S*k_i*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*k_SP*mu_max*s_in);

        DFs=(1/3600*s_in*(1/12960000*x1*(x2*x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2 -1/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) + x4/Y_pD*(x2 + 2*x4*k_SP)/(k_i*x2^2 +x2*x4 + k_SP*x4^2)^2 + x2/Y_pD*(x4 + 2*k_i*x2)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2- 2*x2*x4/Y_pD*(x4 + 2*k_i*x2)*(x2 + 2*x4*k_SP)/(k_i*x2^2 + x2*x4 +k_SP*x4^2)^3) + 1/12960000*x1*s_in*(2/Y_xD*mu_max/(x2 + k_S*x1)^2 -2*x2/Y_xD*mu_max/(x2 + k_S*x1)^3 + 2*x4/Y_pD*(x4 + 2*k_i*x2)/(k_i*x2^2 + x2*x4 +k_SP*x4^2)^2 + 2*k_i*x2*x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2 -2*x2*x4/Y_pD*(x4 + 2*k_i*x2)^2/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^3)) +1/46656000000*x1*(2*x2/Y_pD*(x2 + 2*x4*k_SP)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2 +2*x2*x4/Y_pD*k_SP/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2 - 2*x2*x4/Y_pD*(x2 +2*x4*k_SP)^2/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^3) +1/46656000000*x1*s_in*(x2*x4/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2 -1/Y_pD/(k_i*x2^2 + x2*x4 + k_SP*x4^2) + x4/Y_pD*(x2 + 2*x4*k_SP)/(k_i*x2^2 +x2*x4 + k_SP*x4^2)^2 + x2/Y_pD*(x4 + 2*k_i*x2)/(k_i*x2^2 + x2*x4 + k_SP*x4^2)^2- 2*x2*x4/Y_pD*(x4 + 2*k_i*x2)*(x2 + 2*x4*k_SP)/(k_i*x2^2 + x2*x4 +k_SP*x4^2)^3))*(12960000*k_i^2*kdx*x2^6*Y_pD*Y_xD +12960000*kdx*x2^4*x4^2*Y_pD*Y_xD - 12960000*k_i^2*x2^6*Y_pD*Y_xD*mu_max -12960000*x2^4*x4^2*Y_pD*Y_xD*mu_max - 25920000*x2^3*x4^3*Y_pD*Y_xD*k_SP*mu_max +12960000*kdx*x2^2*x4^4*Y_pD*Y_xD*k_SP^2 - 25920000*k_i*x2^5*x4*Y_pD*Y_xD*mu_max- 12960000*x2^2*x4^4*Y_pD*Y_xD*k_SP^2*mu_max +25920000*kdx*x2^3*x4^3*Y_pD*Y_xD*k_SP + 25920000*k_i*kdx*x2^5*x4*Y_pD*Y_xD -25920000*k_i*x2^4*x4^2*Y_pD*Y_xD*k_SP*mu_max +12960000*k_S^2*k_i^2*kdx*x1^2*x2^4*Y_pD*Y_xD +12960000*k_S^2*kdx*x1^2*x2^2*x4^2*Y_pD*Y_xD +25920000*k_S*k_i^2*kdx*x1*x2^5*Y_pD*Y_xD +25920000*k_S*kdx*x1*x2^3*x4^2*Y_pD*Y_xD +12960000*k_S^2*kdx*x1^2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_i*kdx*x2^4*x4^2*Y_pD*Y_xD*k_SP -12960000*k_S*k_i^2*x1*x2^5*Y_pD*Y_xD*mu_max -12960000*k_S*x1*x2^3*x4^2*Y_pD*Y_xD*mu_max -25920000*k_S*x1*x2^2*x4^3*Y_pD*Y_xD*k_SP*mu_max -12960000*k_S*x1*x2*x4^4*Y_pD*Y_xD*k_SP^2*mu_max +25920000*k_S^2*kdx*x1^2*x2*x4^3*Y_pD*Y_xD*k_SP -25920000*k_S*k_i*x1*x2^4*x4*Y_pD*Y_xD*mu_max +51840000*k_S*kdx*x1*x2^2*x4^3*Y_pD*Y_xD*k_SP +25920000*k_S*kdx*x1*x2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_S^2*k_i*kdx*x1^2*x2^3*x4*Y_pD*Y_xD +51840000*k_S*k_i*kdx*x1*x2^4*x4*Y_pD*Y_xD -25920000*k_S*k_i*x1*x2^3*x4^2*Y_pD*Y_xD*k_SP*mu_max +25920000*k_S^2*k_i*kdx*x1^2*x2^2*x4^2*Y_pD*Y_xD*k_SP +51840000*k_S*k_i*kdx*x1*x2^3*x4^2*Y_pD*Y_xD*k_SP)/(k_i*kdx*x1*x2^5*Y_xD -k_i*x1*x2^5*Y_xD*mu_max + 2*k_S*k_i*kdx*x1^2*x2^4*Y_xD -kdx*x1*x2^3*x4^2*Y_xD*k_SP - k_S*k_i*x1^2*x2^4*Y_xD*mu_max +k_S^2*k_i*kdx*x1^3*x2^3*Y_xD + x1*x2^3*x4^2*Y_xD*k_SP*mu_max -k_i*kdx*x1*x2^4*x4*Y_xD*s_in - x1*x2^2*x4^3*Y_xD*k_SP*mu_max*s_in +k_S*x1^2*x2^2*x4^2*Y_xD*k_SP*mu_max + k_S^2*kdx*x1^3*x4^3*Y_xD*k_SP*s_in +k_S*x1^2*x2^2*x4^2*Y_xD*mu_max*s_in + k_i*x1*x2^4*x4*Y_xD*mu_max*s_in +kdx*x1*x2^2*x4^3*Y_xD*k_SP*s_in - 2*k_S*kdx*x1^2*x2^2*x4^2*Y_xD*k_SP -k_S^2*kdx*x1^3*x2*x4^2*Y_xD*k_SP - k_S^2*k_i*kdx*x1^3*x2^2*x4*Y_xD*s_in +k_S*k_i^2*kdx*x1^2*x2^4*Y_pD*mu_max*s_in +k_S*kdx*x1^2*x2^2*x4^2*Y_pD*mu_max*s_in - 2*k_S*k_i*kdx*x1^2*x2^3*x4*Y_xD*s_in +k_S*kdx*x1^2*x4^4*Y_pD*k_SP^2*mu_max*s_in +2*k_S*kdx*x1^2*x2*x4^3*Y_xD*k_SP*s_in + 2*k_S*k_i*x1^2*x2^3*x4*Y_xD*mu_max*s_in+ k_S*m_D*x1^2*x4^4*Y_pD*Y_xD*k_SP^2*mu_max*s_in +2*k_S*kdx*x1^2*x2*x4^3*Y_pD*k_SP*mu_max*s_in +k_S*k_i^2*m_D*x1^2*x2^4*Y_pD*Y_xD*mu_max*s_in +k_S*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*mu_max*s_in +2*k_S*k_i*kdx*x1^2*x2^3*x4*Y_pD*mu_max*s_in +2*k_S*k_i*m_D*x1^2*x2^3*x4*Y_pD*Y_xD*mu_max*s_in +2*k_S*m_D*x1^2*x2*x4^3*Y_pD*Y_xD*k_SP*mu_max*s_in +2*k_S*k_i*kdx*x1^2*x2^2*x4^2*Y_pD*k_SP*mu_max*s_in +2*k_S*k_i*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*k_SP*mu_max*s_in) +1/46656000000*x1*s_in^2*(2*mu_max/(x2 + k_S*x1)^2 - 2*x2*mu_max/(x2 +k_S*x1)^3)/(k_i*kdx*x1*x2^5*Y_xD - k_i*x1*x2^5*Y_xD*mu_max +2*k_S*k_i*kdx*x1^2*x2^4*Y_xD - kdx*x1*x2^3*x4^2*Y_xD*k_SP -k_S*k_i*x1^2*x2^4*Y_xD*mu_max + k_S^2*k_i*kdx*x1^3*x2^3*Y_xD +x1*x2^3*x4^2*Y_xD*k_SP*mu_max - k_i*kdx*x1*x2^4*x4*Y_xD*s_in -x1*x2^2*x4^3*Y_xD*k_SP*mu_max*s_in + k_S*x1^2*x2^2*x4^2*Y_xD*k_SP*mu_max +k_S^2*kdx*x1^3*x4^3*Y_xD*k_SP*s_in + k_S*x1^2*x2^2*x4^2*Y_xD*mu_max*s_in +k_i*x1*x2^4*x4*Y_xD*mu_max*s_in + kdx*x1*x2^2*x4^3*Y_xD*k_SP*s_in -2*k_S*kdx*x1^2*x2^2*x4^2*Y_xD*k_SP - k_S^2*kdx*x1^3*x2*x4^2*Y_xD*k_SP -k_S^2*k_i*kdx*x1^3*x2^2*x4*Y_xD*s_in + k_S*k_i^2*kdx*x1^2*x2^4*Y_pD*mu_max*s_in+ k_S*kdx*x1^2*x2^2*x4^2*Y_pD*mu_max*s_in - 2*k_S*k_i*kdx*x1^2*x2^3*x4*Y_xD*s_in+ k_S*kdx*x1^2*x4^4*Y_pD*k_SP^2*mu_max*s_in +2*k_S*kdx*x1^2*x2*x4^3*Y_xD*k_SP*s_in + 2*k_S*k_i*x1^2*x2^3*x4*Y_xD*mu_max*s_in+ k_S*m_D*x1^2*x4^4*Y_pD*Y_xD*k_SP^2*mu_max*s_in +2*k_S*kdx*x1^2*x2*x4^3*Y_pD*k_SP*mu_max*s_in +k_S*k_i^2*m_D*x1^2*x2^4*Y_pD*Y_xD*mu_max*s_in +k_S*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*mu_max*s_in +2*k_S*k_i*kdx*x1^2*x2^3*x4*Y_pD*mu_max*s_in +2*k_S*k_i*m_D*x1^2*x2^3*x4*Y_pD*Y_xD*mu_max*s_in +2*k_S*m_D*x1^2*x2*x4^3*Y_pD*Y_xD*k_SP*mu_max*s_in +2*k_S*k_i*kdx*x1^2*x2^2*x4^2*Y_pD*k_SP*mu_max*s_in +2*k_S*k_i*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*k_SP*mu_max*s_in)*(12960000*x2^4*x4^2*Y_xD+ 12960000*x2^3*x4^3*Y_xD*k_SP + 12960000*k_i^2*x2^6*Y_pD*mu_max +12960000*x2^4*x4^2*Y_pD*mu_max + 12960000*k_i*x2^5*x4*Y_xD +12960000*k_S^2*x1^2*x2^2*x4^2*Y_xD + 25920000*k_i*x2^5*x4*Y_pD*mu_max +25920000*k_S*x1*x2^3*x4^2*Y_xD + 12960000*x2^2*x4^4*Y_pD*k_SP^2*mu_max +12960000*k_i^2*m_D*x2^6*Y_pD*Y_xD + 12960000*m_D*x2^4*x4^2*Y_pD*Y_xD +25920000*x2^3*x4^3*Y_pD*k_SP*mu_max + 12960000*m_D*x2^2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_S*x1*x2^2*x4^3*Y_xD*k_SP + 12960000*k_S*k_i^2*x1*x2^5*Y_pD*mu_max +12960000*k_S*x1*x2^3*x4^2*Y_pD*mu_max + 12960000*k_S^2*k_i*x1^2*x2^3*x4*Y_xD +25920000*k_S*k_i*x1*x2^4*x4*Y_xD + 25920000*m_D*x2^3*x4^3*Y_pD*Y_xD*k_SP +25920000*k_i*x2^4*x4^2*Y_pD*k_SP*mu_max + 12960000*k_S^2*x1^2*x2*x4^3*Y_xD*k_SP+ 25920000*k_i*m_D*x2^5*x4*Y_pD*Y_xD + 25920000*k_S*k_i*x1*x2^4*x4*Y_pD*mu_max +12960000*k_S^2*k_i^2*m_D*x1^2*x2^4*Y_pD*Y_xD +12960000*k_S^2*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD +25920000*k_S*k_i^2*m_D*x1*x2^5*Y_pD*Y_xD +25920000*k_S*m_D*x1*x2^3*x4^2*Y_pD*Y_xD +12960000*k_S^2*m_D*x1^2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_i*m_D*x2^4*x4^2*Y_pD*Y_xD*k_SP +25920000*k_S*x1*x2^2*x4^3*Y_pD*k_SP*mu_max +12960000*k_S*x1*x2*x4^4*Y_pD*k_SP^2*mu_max +25920000*k_S^2*m_D*x1^2*x2*x4^3*Y_pD*Y_xD*k_SP +51840000*k_S*m_D*x1*x2^2*x4^3*Y_pD*Y_xD*k_SP +25920000*k_S*m_D*x1*x2*x4^4*Y_pD*Y_xD*k_SP^2 +25920000*k_S^2*k_i*m_D*x1^2*x2^3*x4*Y_pD*Y_xD +25920000*k_S*k_i*x1*x2^3*x4^2*Y_pD*k_SP*mu_max +51840000*k_S*k_i*m_D*x1*x2^4*x4*Y_pD*Y_xD +25920000*k_S^2*k_i*m_D*x1^2*x2^2*x4^2*Y_pD*Y_xD*k_SP +51840000*k_S*k_i*m_D*x1*x2^3*x4^2*Y_pD*Y_xD*k_SP);

        if DFs <> 0
            fin=NFs/DFs;
        else
            fin=f_max; // Prevents fin blowing up
        end;
    end;

    if fin < 0, fin=0; end; // fin must remain between 0 and 200 (fmax)
    if fin>f_max, fin=f_max; end;
    if x4>90000, fin=0; end; // once fermenter is full, fin=0
    Xdot = [(mu_D-kdx)*x1/3600;
    (-sigma_D*x1+s_in*fin)/3600;
    (pi_R*x1-kdp*x3)/3600;
    fin/3600];
    return
endfunction;
//**************************************************************************************