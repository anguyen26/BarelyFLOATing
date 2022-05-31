// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  hsG_0__0 (struct dummyq_struct * I1361, EBLK  * I1356, U  I707);
void  hsG_0__0 (struct dummyq_struct * I1361, EBLK  * I1356, U  I707)
{
    U  I1622;
    U  I1623;
    U  I1624;
    struct futq * I1625;
    struct dummyq_struct * pQ = I1361;
    I1622 = ((U )vcs_clocks) + I707;
    I1624 = I1622 & ((1 << fHashTableSize) - 1);
    I1356->I752 = (EBLK  *)(-1);
    I1356->I753 = I1622;
    if (0 && rmaProfEvtProp) {
        vcs_simpSetEBlkEvtID(I1356);
    }
    if (I1622 < (U )vcs_clocks) {
        I1623 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1356, I1623 + 1, I1622);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I707 == 1)) {
        I1356->I755 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I752 = I1356;
        peblkFutQ1Tail = I1356;
    }
    else if ((I1625 = pQ->I1264[I1624].I775)) {
        I1356->I755 = (struct eblk *)I1625->I773;
        I1625->I773->I752 = (RP )I1356;
        I1625->I773 = (RmaEblk  *)I1356;
    }
    else {
        sched_hsopt(pQ, I1356, I1622);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
