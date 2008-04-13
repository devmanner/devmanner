#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* Workaround for mapstart: the only op which needs a different ppaddr */
#undef Perl_pp_mapstart
#define Perl_pp_mapstart Perl_pp_grepstart
#define XS_DynaLoader_boot_DynaLoader boot_DynaLoader
EXTERN_C void boot_DynaLoader (pTHX_ CV* cv);

static void xs_init (pTHX);
static void dl_init (pTHX);
static PerlInterpreter *my_perl;


#ifdef BROKEN_STATIC_REDECL
#define Static extern
#else
#define Static static
#endif /* BROKEN_STATIC_REDECL */

#ifdef BROKEN_UNION_INIT
/*
 * Cribbed from cv.h with ANY (a union) replaced by void*.
 * Some pre-Standard compilers can't cope with initialising unions. Ho hum.
 */
typedef struct {
    char *	xpv_pv;		/* pointer to malloced string */
    STRLEN	xpv_cur;	/* length of xp_pv as a C string */
    STRLEN	xpv_len;	/* allocated size */
    IV		xof_off;	/* integer value */
    double	xnv_nv;		/* numeric value, if any */
    MAGIC*	xmg_magic;	/* magic for scalar array */
    HV*		xmg_stash;	/* class package */

    HV *	xcv_stash;
    OP *	xcv_start;
    OP *	xcv_root;
    void      (*xcv_xsub) (CV*);
    void *	xcv_xsubany;
    GV *	xcv_gv;
    char *	xcv_file;
    long	xcv_depth;	/* >= 2 indicates recursive call */
    AV *	xcv_padlist;
    CV *	xcv_outside;
#ifdef USE_THREADS
    perl_mutex *xcv_mutexp;
    struct perl_thread *xcv_owner;	/* current owner thread */
#endif /* USE_THREADS */
    cv_flags_t	xcv_flags;
} XPVCV_or_similar;
#define ANYINIT(i) i
#else
#define XPVCV_or_similar XPVCV
#define ANYINIT(i) {i}
#endif /* BROKEN_UNION_INIT */
#define Nullany ANYINIT(0)

#define UNUSED 0
#define sym_0 0

static GV *gv_list[79];

Static OP op_list[2];
Static BINOP binop_list[1];
Static LISTOP listop_list[2];
Static SVOP svop_list[2];
Static COP cop_list[1];
Static SV sv_list[70];
Static XPV xpv_list[54];
Static XPVAV xpvav_list[3];
Static XPVHV xpvhv_list[1];
Static XPVIV xpviv_list[1];
Static XPVMG xpvmg_list[1];
Static XPVIO xpvio_list[3];
static HV *hv0;
/* bootstrap printx.pl */

static OP op_list[2] = {
	{ (OP*)&cop_list[0], (OP*)&cop_list[0], NULL, 0, 177, 65535, 0x0, 0x0 },
	{ (OP*)&svop_list[0], (OP*)&binop_list[0], NULL, 0, 3, 65535, 0x2, 0x0 },
};

static BINOP binop_list[1] = {
	{ (OP*)&listop_list[1], 0, NULL, 1, 61, 65535, 0x6, 0x2, (OP*)&svop_list[0], (OP*)&svop_list[1] },
};

static LISTOP listop_list[2] = {
	{ 0, 0, NULL, 0, 178, 65535, 0xd, 0x40, &op_list[0], (OP*)&listop_list[1], 3 },
	{ (OP*)&listop_list[0], 0, NULL, 0, 209, 65535, 0x5, 0x0, &op_list[1], (OP*)&binop_list[0], 1 },
};

static SVOP svop_list[2] = {
	{ (OP*)&svop_list[1], (OP*)&svop_list[1], NULL, 0, 5, 65535, 0x2, 0x0, Nullsv },
	{ (OP*)&binop_list[0], 0, NULL, 0, 5, 65535, 0x2, 0x0, Nullsv },
};

static COP cop_list[1] = {
	{ &op_list[1], (OP*)&listop_list[1], NULL, 0, 174, 65535, 0x1, 0x0, 0, NULL, NULL, 1348, 0, 3 },
};

static SV sv_list[70] = {
	{ &xpv_list[0], 1, 0x4840004 },
	{ &xpviv_list[0], 1, 0x81810001 },
	{ &xpv_list[1], 1, 0x4040004 },
	{ &xpv_list[2], 1, 0x4040004 },
	{ &xpv_list[3], 1, 0x4040004 },
	{ &xpv_list[4], 1, 0x4040004 },
	{ &xpv_list[5], 1, 0x4040004 },
	{ &xpv_list[6], 1, 0x4040004 },
	{ &xpv_list[7], 1, 0x4040004 },
	{ &xpvmg_list[0], 1, 0x4006007 },
	{ &xpv_list[8], 1, 0x4040004 },
	{ &xpv_list[9], 1, 0x4040004 },
	{ 0, 1, 0x0 },
	{ &xpv_list[10], 1, 0x4040004 },
	{ &xpv_list[11], 1, 0x4040004 },
	{ &xpv_list[12], 1, 0x4040004 },
	{ 0, 1, 0x0 },
	{ &xpvio_list[0], 2, 0x100f },
	{ &xpv_list[13], 1, 0x4040004 },
	{ &xpv_list[14], 1, 0x4040004 },
	{ &xpv_list[15], 1, 0x4040004 },
	{ &xpv_list[16], 1, 0x4040004 },
	{ &xpv_list[17], 1, 0x4040004 },
	{ &xpv_list[18], 1, 0x4040004 },
	{ &xpv_list[19], 1, 0x4040004 },
	{ &xpv_list[20], 1, 0x4040004 },
	{ &xpv_list[21], 1, 0x4040004 },
	{ &xpv_list[22], 1, 0x4040004 },
	{ &xpv_list[23], 1, 0x4040004 },
	{ &xpv_list[24], 1, 0x4040004 },
	{ &xpv_list[25], 1, 0x4040004 },
	{ &xpv_list[26], 1, 0x4040004 },
	{ 0, 1, 0x0 },
	{ &xpv_list[27], 1, 0x4040004 },
	{ &xpv_list[28], 1, 0x4040004 },
	{ &xpv_list[29], 1, 0x4040004 },
	{ &xpv_list[30], 1, 0x4040004 },
	{ &xpv_list[31], 1, 0x4040004 },
	{ 0, 1, 0x0 },
	{ &xpvio_list[1], 2, 0x100f },
	{ 0, 1, 0x0 },
	{ &xpvav_list[0], 1, 0xa },
	{ &xpv_list[32], 1, 0x4040004 },
	{ &xpv_list[33], 1, 0x4040004 },
	{ &xpv_list[34], 1, 0x4040004 },
	{ &xpv_list[35], 1, 0x4040004 },
	{ &xpv_list[36], 1, 0x4040004 },
	{ &xpv_list[37], 1, 0x4040004 },
	{ &xpv_list[38], 1, 0x4040004 },
	{ &xpv_list[39], 1, 0x4040004 },
	{ &xpv_list[40], 1, 0x4040004 },
	{ &xpv_list[41], 1, 0x4040004 },
	{ &xpv_list[42], 1, 0x4040004 },
	{ &xpv_list[43], 1, 0x4040004 },
	{ &xpv_list[44], 1, 0x4040004 },
	{ &xpv_list[45], 1, 0x4040004 },
	{ &xpv_list[46], 1, 0x4040004 },
	{ &xpv_list[47], 1, 0x4040004 },
	{ &xpvhv_list[0], 1, 0x2000000b },
	{ &xpv_list[48], 1, 0x4040004 },
	{ &xpv_list[49], 1, 0x4040004 },
	{ 0, 1, 0x0 },
	{ &xpvio_list[2], 2, 0x100f },
	{ &xpv_list[50], 1, 0x4040004 },
	{ &xpv_list[51], 1, 0x4040004 },
	{ &xpv_list[52], 1, 0x4040004 },
	{ &xpv_list[53], 1, 0x4040004 },
	{ &xpvav_list[1], 1, 0xa },
	{ &xpvav_list[2], 1, 0xa },
	{ 0, 1, 0x200 },
};

static XPV xpv_list[54] = {
	{ 0, 1, 2 },
	{ 0, 4, 5 },
	{ 0, 38, 39 },
	{ 0, 45, 46 },
	{ 0, 33, 34 },
	{ 0, 12, 13 },
	{ 0, 51, 52 },
	{ 0, 38, 39 },
	{ 0, 3, 4 },
	{ 0, 44, 45 },
	{ 0, 36, 37 },
	{ 0, 7, 8 },
	{ 0, 42, 43 },
	{ 0, 36, 37 },
	{ 0, 30, 31 },
	{ 0, 28, 29 },
	{ 0, 11, 12 },
	{ 0, 43, 44 },
	{ 0, 46, 47 },
	{ 0, 34, 35 },
	{ 0, 9, 10 },
	{ 0, 12, 13 },
	{ 0, 41, 42 },
	{ 0, 28, 29 },
	{ 0, 28, 29 },
	{ 0, 30, 31 },
	{ 0, 32, 33 },
	{ 0, 41, 42 },
	{ 0, 35, 36 },
	{ 0, 27, 28 },
	{ 0, 37, 38 },
	{ 0, 10, 11 },
	{ 0, 31, 32 },
	{ 0, 31, 32 },
	{ 0, 20, 21 },
	{ 0, 41, 42 },
	{ 0, 41, 42 },
	{ 0, 30, 31 },
	{ 0, 41, 42 },
	{ 0, 30, 31 },
	{ 0, 24, 25 },
	{ 0, 1, 2 },
	{ 0, 31, 32 },
	{ 0, 20, 21 },
	{ 0, 41, 42 },
	{ 0, 30, 31 },
	{ 0, 24, 25 },
	{ 0, 1, 2 },
	{ 0, 44, 45 },
	{ 0, 43, 44 },
	{ 0, 40, 41 },
	{ 0, 38, 39 },
	{ 0, 32, 33 },
	{ 0, 9, 10 },
};

static XPVAV xpvav_list[3] = {
	{ 0, -1, -1, 0, 0.0, 0, Nullhv, 0, 0, 0x1 },
	{ 0, -1, -1, 0, 0.0, 0, Nullhv, 0, 0, 0x1 },
	{ 0, -1, -1, 0, 0.0, 0, Nullhv, 0, 0, 0x1 },
};

static XPVHV xpvhv_list[1] = {
	{ 0, 0, 31, 0, 0.0, 0, Nullhv, -1, 0, 0, 0 },
};

static XPVIV xpviv_list[1] = {
	{ 0, 0, 0, 10 },
};

static XPVMG xpvmg_list[1] = {
	{ 0, 12, 13, 0, 0, 0, 0 },
};

static XPVIO xpvio_list[3] = {
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, Nullgv, 0, Nullgv, 0, Nullgv, 0, '>', 0x0 },
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, Nullgv, 0, Nullgv, 0, Nullgv, 0, '\000', 0x0 },
	{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, Nullgv, 0, Nullgv, 0, Nullgv, 0, '\000', 0x0 },
};

static int perl_init()
{
	dTHR;
	dTARG;
	djSP;
	listop_list[0].op_ppaddr = PL_ppaddr[OP_LEAVE];
	op_list[0].op_ppaddr = PL_ppaddr[OP_ENTER];
	cop_list[0].op_ppaddr = PL_ppaddr[OP_NEXTSTATE];
	CopFILE_set(&cop_list[0], "printx.pl");
	CopSTASHPV_set(&cop_list[0], "main");
	listop_list[1].op_ppaddr = PL_ppaddr[OP_PRINT];
	op_list[1].op_ppaddr = PL_ppaddr[OP_PUSHMARK];
	binop_list[0].op_ppaddr = PL_ppaddr[OP_REPEAT];
	xpv_list[0].xpv_pv = savepvn("X", 1);
	svop_list[0].op_ppaddr = PL_ppaddr[OP_CONST];
	svop_list[0].op_sv = (SV*)&sv_list[0];
	svop_list[1].op_ppaddr = PL_ppaddr[OP_CONST];
	svop_list[1].op_sv = (SV*)&sv_list[1];
	gv_list[0] = gv_fetchpv("main::STDOUT", TRUE, SVt_PV);
	SvFLAGS(gv_list[0]) = 0x600d;
	GvFLAGS(gv_list[0]) = 0x2;
	GvLINE(gv_list[0]) = 0;
	SvREFCNT(gv_list[0]) += 8;
	GvREFCNT(gv_list[0]) += 2;
	gv_list[1] = gv_fetchpv("main::\001", TRUE, SVt_PV);
	SvFLAGS(gv_list[1]) = 0x600d;
	GvFLAGS(gv_list[1]) = 0x2;
	GvLINE(gv_list[1]) = 534;
	SvREFCNT(gv_list[1]) += 5;
	GvREFCNT(gv_list[1]) += 2;
	gv_list[2] = gv_fetchpv("main::~", TRUE, SVt_PV);
	SvFLAGS(gv_list[2]) = 0x600d;
	GvFLAGS(gv_list[2]) = 0x2;
	GvLINE(gv_list[2]) = 503;
	SvREFCNT(gv_list[2]) += 4;
	GvREFCNT(gv_list[2]) += 2;
	gv_list[3] = gv_fetchpv("main::_<IO.c", TRUE, SVt_PV);
	SvFLAGS(gv_list[3]) = 0x600d;
	GvFLAGS(gv_list[3]) = 0x2;
	GvLINE(gv_list[3]) = 95;
	SvREFCNT(gv_list[3]) += 1;
	GvREFCNT(gv_list[3]) += 2;
	xpv_list[1].xpv_pv = savepvn("IO.c", 4);
	GvSV(gv_list[3]) = &sv_list[2];
	GvFILE(gv_list[3]) = "/usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm";
	gv_list[4] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/B/C.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[4]) = 0x600d;
	GvFLAGS(gv_list[4]) = 0x2;
	GvLINE(gv_list[4]) = 2;
	SvREFCNT(gv_list[4]) += 861;
	GvREFCNT(gv_list[4]) += 2;
	xpv_list[2].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/B/C.pm", 38);
	GvSV(gv_list[4]) = &sv_list[3];
	GvFILE(gv_list[4]) = "(eval 1)";
	gv_list[5] = gv_fetchpv("main::STDIN", TRUE, SVt_PV);
	SvFLAGS(gv_list[5]) = 0x600d;
	GvFLAGS(gv_list[5]) = 0x2;
	GvLINE(gv_list[5]) = 0;
	SvREFCNT(gv_list[5]) += 1;
	GvREFCNT(gv_list[5]) += 2;
	gv_list[6] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/auto/IO/IO.so", TRUE, SVt_PV);
	SvFLAGS(gv_list[6]) = 0x600d;
	GvFLAGS(gv_list[6]) = 0x2;
	GvLINE(gv_list[6]) = 90;
	SvREFCNT(gv_list[6]) += 1;
	GvREFCNT(gv_list[6]) += 2;
	xpv_list[3].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/auto/IO/IO.so", 45);
	GvSV(gv_list[6]) = &sv_list[4];
	GvFILE(gv_list[6]) = "/usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm";
	gv_list[7] = gv_fetchpv("main::\b", TRUE, SVt_PV);
	SvFLAGS(gv_list[7]) = 0x600d;
	GvFLAGS(gv_list[7]) = 0x2;
	GvLINE(gv_list[7]) = 0;
	SvREFCNT(gv_list[7]) += 4;
	GvREFCNT(gv_list[7]) += 2;
	gv_list[8] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/File/Spec.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[8]) = 0x600d;
	GvFLAGS(gv_list[8]) = 0x2;
	GvLINE(gv_list[8]) = 113;
	SvREFCNT(gv_list[8]) += 7;
	GvREFCNT(gv_list[8]) += 2;
	xpv_list[4].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/File/Spec.pm", 33);
	GvSV(gv_list[8]) = &sv_list[5];
	GvFILE(gv_list[8]) = "/usr/lib/perl5/5.6.0/i386-linux/IO/File.pm";
	gv_list[9] = gv_fetchpv("main::_<DynaLoader.c", TRUE, SVt_PV);
	SvFLAGS(gv_list[9]) = 0x600d;
	GvFLAGS(gv_list[9]) = 0x2;
	GvLINE(gv_list[9]) = 26;
	SvREFCNT(gv_list[9]) += 1;
	GvREFCNT(gv_list[9]) += 2;
	xpv_list[5].xpv_pv = savepvn("DynaLoader.c", 12);
	GvSV(gv_list[9]) = &sv_list[6];
	GvFILE(gv_list[9]) = "/usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm";
	gv_list[10] = gv_fetchpv("main::\f", TRUE, SVt_PV);
	SvFLAGS(gv_list[10]) = 0x600d;
	GvFLAGS(gv_list[10]) = 0x2;
	GvLINE(gv_list[10]) = 526;
	SvREFCNT(gv_list[10]) += 3;
	GvREFCNT(gv_list[10]) += 2;
	gv_list[11] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/auto/Fcntl/Fcntl.so", TRUE, SVt_PV);
	SvFLAGS(gv_list[11]) = 0x600d;
	GvFLAGS(gv_list[11]) = 0x2;
	GvLINE(gv_list[11]) = 90;
	SvREFCNT(gv_list[11]) += 1;
	GvREFCNT(gv_list[11]) += 2;
	xpv_list[6].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/auto/Fcntl/Fcntl.so", 51);
	GvSV(gv_list[11]) = &sv_list[7];
	GvFILE(gv_list[11]) = "/usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm";
	gv_list[12] = gv_fetchpv("main::\017", TRUE, SVt_PV);
	SvFLAGS(gv_list[12]) = 0x600d;
	GvFLAGS(gv_list[12]) = 0x2;
	GvLINE(gv_list[12]) = 13;
	SvREFCNT(gv_list[12]) += 7;
	GvREFCNT(gv_list[12]) += 2;
	gv_list[13] = gv_fetchpv("main::\022", TRUE, SVt_PV);
	SvFLAGS(gv_list[13]) = 0x600d;
	GvFLAGS(gv_list[13]) = 0x2;
	GvLINE(gv_list[13]) = 0;
	SvREFCNT(gv_list[13]) += 1;
	GvREFCNT(gv_list[13]) += 2;
	gv_list[14] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/File/Spec/Unix.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[14]) = 0x600d;
	GvFLAGS(gv_list[14]) = 0x2;
	GvLINE(gv_list[14]) = 14;
	SvREFCNT(gv_list[14]) += 98;
	GvREFCNT(gv_list[14]) += 2;
	xpv_list[7].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/File/Spec/Unix.pm", 38);
	GvSV(gv_list[14]) = &sv_list[8];
	GvFILE(gv_list[14]) = "/usr/lib/perl5/5.6.0/File/Spec.pm";
	gv_list[15] = gv_fetchpv("main::\026", TRUE, SVt_PV);
	SvFLAGS(gv_list[15]) = 0x600d;
	GvFLAGS(gv_list[15]) = 0x2;
	GvLINE(gv_list[15]) = 19;
	SvREFCNT(gv_list[15]) += 1;
	GvREFCNT(gv_list[15]) += 2;
	gv_list[16] = gv_fetchpv("main::\027", TRUE, SVt_PV);
	SvFLAGS(gv_list[16]) = 0x600d;
	GvFLAGS(gv_list[16]) = 0x2;
	GvLINE(gv_list[16]) = 196;
	SvREFCNT(gv_list[16]) += 3;
	GvREFCNT(gv_list[16]) += 2;
	gv_list[17] = gv_fetchpv("main::\030", TRUE, SVt_PV);
	SvFLAGS(gv_list[17]) = 0x600d;
	GvFLAGS(gv_list[17]) = 0x2;
	GvLINE(gv_list[17]) = 0;
	SvREFCNT(gv_list[17]) += 1;
	GvREFCNT(gv_list[17]) += 2;
	gv_list[18] = gv_fetchpv("main::\027ARNING_BITS", TRUE, SVt_PV);
	SvFLAGS(gv_list[18]) = 0x600d;
	GvFLAGS(gv_list[18]) = 0x2;
	GvLINE(gv_list[18]) = 246;
	SvREFCNT(gv_list[18]) += 5;
	GvREFCNT(gv_list[18]) += 2;
	xpvmg_list[0].xpv_pv = savepvn("\000\000\000\000\000\000\000\000\000\000\000\000", 12);
	sv_magic((SV*)&sv_list[9], (SV*)gv_list[18], '\000', "\027ARNING_BITS", 12);
	GvSV(gv_list[18]) = &sv_list[9];
	GvFILE(gv_list[18]) = "/usr/lib/perl5/5.6.0/warnings.pm";
	gv_list[19] = gv_fetchpv("main::SIG", TRUE, SVt_PV);
	SvFLAGS(gv_list[19]) = 0x600d;
	GvFLAGS(gv_list[19]) = 0x2;
	GvLINE(gv_list[19]) = 53;
	SvREFCNT(gv_list[19]) += 74;
	GvREFCNT(gv_list[19]) += 2;
	gv_list[20] = gv_fetchpv("main::_<B.c", TRUE, SVt_PV);
	SvFLAGS(gv_list[20]) = 0x600d;
	GvFLAGS(gv_list[20]) = 0x2;
	GvLINE(gv_list[20]) = 95;
	SvREFCNT(gv_list[20]) += 1;
	GvREFCNT(gv_list[20]) += 2;
	xpv_list[8].xpv_pv = savepvn("B.c", 3);
	GvSV(gv_list[20]) = &sv_list[10];
	GvFILE(gv_list[20]) = "/usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm";
	gv_list[21] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/IO/Handle.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[21]) = 0x600d;
	GvFLAGS(gv_list[21]) = 0x2;
	GvLINE(gv_list[21]) = 51;
	SvREFCNT(gv_list[21]) += 160;
	GvREFCNT(gv_list[21]) += 2;
	xpv_list[9].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/IO/Handle.pm", 44);
	GvSV(gv_list[21]) = &sv_list[11];
	GvFILE(gv_list[21]) = "/usr/lib/perl5/5.6.0/i386-linux/IO/Seekable.pm";
	gv_list[22] = gv_fetchpv("main::BEGIN", TRUE, SVt_PV);
	SvFLAGS(gv_list[22]) = 0x600d;
	GvFLAGS(gv_list[22]) = 0x2;
	GvLINE(gv_list[22]) = 0;
	SvREFCNT(gv_list[22]) += 2;
	GvREFCNT(gv_list[22]) += 2;
	GvSV(gv_list[22]) = &sv_list[12];
	GvFILE(gv_list[22]) = "printx.pl";
	gv_list[23] = gv_fetchpv("main::!", TRUE, SVt_PV);
	SvFLAGS(gv_list[23]) = 0x600d;
	GvFLAGS(gv_list[23]) = 0x2;
	GvLINE(gv_list[23]) = 205;
	SvREFCNT(gv_list[23]) += 12;
	GvREFCNT(gv_list[23]) += 2;
	gv_list[24] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/O.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[24]) = 0x600d;
	GvFLAGS(gv_list[24]) = 0x2;
	GvLINE(gv_list[24]) = 0;
	SvREFCNT(gv_list[24]) += 17;
	GvREFCNT(gv_list[24]) += 2;
	xpv_list[10].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/O.pm", 36);
	GvSV(gv_list[24]) = &sv_list[13];
	GvFILE(gv_list[24]) = "printx.pl";
	gv_list[25] = gv_fetchpv("main::\"", TRUE, SVt_PV);
	SvFLAGS(gv_list[25]) = 0x600d;
	GvFLAGS(gv_list[25]) = 0x2;
	GvLINE(gv_list[25]) = 0;
	SvREFCNT(gv_list[25]) += 5;
	GvREFCNT(gv_list[25]) += 2;
	gv_list[26] = gv_fetchpv("main::_<Fcntl.c", TRUE, SVt_PV);
	SvFLAGS(gv_list[26]) = 0x600d;
	GvFLAGS(gv_list[26]) = 0x2;
	GvLINE(gv_list[26]) = 95;
	SvREFCNT(gv_list[26]) += 1;
	GvREFCNT(gv_list[26]) += 2;
	xpv_list[11].xpv_pv = savepvn("Fcntl.c", 7);
	GvSV(gv_list[26]) = &sv_list[14];
	GvFILE(gv_list[26]) = "/usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm";
	gv_list[27] = gv_fetchpv("main::$", TRUE, SVt_PV);
	SvFLAGS(gv_list[27]) = 0x600d;
	GvFLAGS(gv_list[27]) = 0x2;
	GvLINE(gv_list[27]) = 0;
	SvREFCNT(gv_list[27]) += 1;
	GvREFCNT(gv_list[27]) += 2;
	gv_list[28] = gv_fetchpv("main::%", TRUE, SVt_PV);
	SvFLAGS(gv_list[28]) = 0x600d;
	GvFLAGS(gv_list[28]) = 0x2;
	GvLINE(gv_list[28]) = 482;
	SvREFCNT(gv_list[28]) += 4;
	GvREFCNT(gv_list[28]) += 2;
	gv_list[29] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/IO/File.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[29]) = 0x600d;
	GvFLAGS(gv_list[29]) = 0x2;
	GvLINE(gv_list[29]) = 9;
	SvREFCNT(gv_list[29]) += 37;
	GvREFCNT(gv_list[29]) += 2;
	xpv_list[12].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/IO/File.pm", 42);
	GvSV(gv_list[29]) = &sv_list[15];
	GvFILE(gv_list[29]) = "/usr/lib/perl5/5.6.0/FileHandle.pm";
	gv_list[30] = gv_fetchpv("main::stdout", TRUE, SVt_PV);
	SvFLAGS(gv_list[30]) = 0x600d;
	GvFLAGS(gv_list[30]) = 0x2;
	GvLINE(gv_list[30]) = 0;
	SvREFCNT(gv_list[30]) += 1;
	GvREFCNT(gv_list[30]) += 2;
	GvSV(gv_list[30]) = &sv_list[16];
	GvFILE(gv_list[30]) = "printx.pl";
	hv0 = gv_stashpv("FileHandle", TRUE);
	SvSTASH((IO*)&sv_list[17]) = hv0;
	GvIOp(gv_list[30]) = (IO*)&sv_list[17];
	gv_list[31] = gv_fetchpv("main::,", TRUE, SVt_PV);
	SvFLAGS(gv_list[31]) = 0x600d;
	GvFLAGS(gv_list[31]) = 0x2;
	GvLINE(gv_list[31]) = 451;
	SvREFCNT(gv_list[31]) += 4;
	GvREFCNT(gv_list[31]) += 2;
	gv_list[32] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/B.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[32]) = 0x600d;
	GvFLAGS(gv_list[32]) = 0x2;
	GvLINE(gv_list[32]) = 2;
	SvREFCNT(gv_list[32]) += 124;
	GvREFCNT(gv_list[32]) += 2;
	xpv_list[13].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/B.pm", 36);
	GvSV(gv_list[32]) = &sv_list[18];
	GvFILE(gv_list[32]) = "/usr/lib/perl5/5.6.0/i386-linux/O.pm";
	gv_list[33] = gv_fetchpv("main::-", TRUE, SVt_PV);
	SvFLAGS(gv_list[33]) = 0x600d;
	GvFLAGS(gv_list[33]) = 0x2;
	GvLINE(gv_list[33]) = 496;
	SvREFCNT(gv_list[33]) += 4;
	GvREFCNT(gv_list[33]) += 2;
	gv_list[34] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/strict.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[34]) = 0x600d;
	GvFLAGS(gv_list[34]) = 0x2;
	GvLINE(gv_list[34]) = 18;
	SvREFCNT(gv_list[34]) += 10;
	GvREFCNT(gv_list[34]) += 2;
	xpv_list[14].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/strict.pm", 30);
	GvSV(gv_list[34]) = &sv_list[19];
	GvFILE(gv_list[34]) = "/usr/lib/perl5/5.6.0/i386-linux/B.pm";
	gv_list[35] = gv_fetchpv("main::.", TRUE, SVt_PV);
	SvFLAGS(gv_list[35]) = 0x600d;
	GvFLAGS(gv_list[35]) = 0x2;
	GvLINE(gv_list[35]) = 473;
	SvREFCNT(gv_list[35]) += 5;
	GvREFCNT(gv_list[35]) += 2;
	gv_list[36] = gv_fetchpv("main::/", TRUE, SVt_PV);
	SvFLAGS(gv_list[36]) = 0x600d;
	GvFLAGS(gv_list[36]) = 0x2;
	GvLINE(gv_list[36]) = 0;
	SvREFCNT(gv_list[36]) += 4;
	GvREFCNT(gv_list[36]) += 2;
	gv_list[37] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/Carp.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[37]) = 0x600d;
	GvFLAGS(gv_list[37]) = 0x2;
	GvLINE(gv_list[37]) = 3;
	SvREFCNT(gv_list[37]) += 16;
	GvREFCNT(gv_list[37]) += 2;
	xpv_list[15].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/Carp.pm", 28);
	GvSV(gv_list[37]) = &sv_list[20];
	GvFILE(gv_list[37]) = "/usr/lib/perl5/5.6.0/i386-linux/O.pm";
	gv_list[38] = gv_fetchpv("main::0", TRUE, SVt_PV);
	SvFLAGS(gv_list[38]) = 0x600d;
	GvFLAGS(gv_list[38]) = 0x2;
	GvLINE(gv_list[38]) = 0;
	SvREFCNT(gv_list[38]) += 2;
	GvREFCNT(gv_list[38]) += 2;
	gv_list[39] = gv_fetchpv("main::1", TRUE, SVt_PV);
	SvFLAGS(gv_list[39]) = 0x600d;
	GvFLAGS(gv_list[39]) = 0x2;
	GvLINE(gv_list[39]) = 142;
	SvREFCNT(gv_list[39]) += 20;
	GvREFCNT(gv_list[39]) += 2;
	gv_list[40] = gv_fetchpv("main::2", TRUE, SVt_PV);
	SvFLAGS(gv_list[40]) = 0x600d;
	GvFLAGS(gv_list[40]) = 0x2;
	GvLINE(gv_list[40]) = 171;
	SvREFCNT(gv_list[40]) += 6;
	GvREFCNT(gv_list[40]) += 2;
	gv_list[41] = gv_fetchpv("main::3", TRUE, SVt_PV);
	SvFLAGS(gv_list[41]) = 0x600d;
	GvFLAGS(gv_list[41]) = 0x2;
	GvLINE(gv_list[41]) = 174;
	SvREFCNT(gv_list[41]) += 3;
	GvREFCNT(gv_list[41]) += 2;
	gv_list[42] = gv_fetchpv("main::_<universal.c", TRUE, SVt_PV);
	SvFLAGS(gv_list[42]) = 0x600d;
	GvFLAGS(gv_list[42]) = 0x2;
	GvLINE(gv_list[42]) = 0;
	SvREFCNT(gv_list[42]) += 1;
	GvREFCNT(gv_list[42]) += 2;
	xpv_list[16].xpv_pv = savepvn("universal.c", 11);
	GvSV(gv_list[42]) = &sv_list[21];
	GvFILE(gv_list[42]) = "printx.pl";
	gv_list[43] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[43]) = 0x600d;
	GvFLAGS(gv_list[43]) = 0x2;
	GvLINE(gv_list[43]) = 9;
	SvREFCNT(gv_list[43]) += 36;
	GvREFCNT(gv_list[43]) += 2;
	xpv_list[17].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm", 43);
	GvSV(gv_list[43]) = &sv_list[22];
	GvFILE(gv_list[43]) = "/usr/lib/perl5/5.6.0/i386-linux/B.pm";
	gv_list[44] = gv_fetchpv("main::STDERR", TRUE, SVt_PV);
	SvFLAGS(gv_list[44]) = 0x600d;
	GvFLAGS(gv_list[44]) = 0x2;
	GvLINE(gv_list[44]) = 0;
	SvREFCNT(gv_list[44]) += 1;
	GvREFCNT(gv_list[44]) += 2;
	gv_list[45] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/IO/Seekable.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[45]) = 0x600d;
	GvFLAGS(gv_list[45]) = 0x2;
	GvLINE(gv_list[45]) = 112;
	SvREFCNT(gv_list[45]) += 19;
	GvREFCNT(gv_list[45]) += 2;
	xpv_list[18].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/IO/Seekable.pm", 46);
	GvSV(gv_list[45]) = &sv_list[23];
	GvFILE(gv_list[45]) = "/usr/lib/perl5/5.6.0/i386-linux/IO/File.pm";
	gv_list[46] = gv_fetchpv("main:::", TRUE, SVt_PV);
	SvFLAGS(gv_list[46]) = 0x600d;
	GvFLAGS(gv_list[46]) = 0x2;
	GvLINE(gv_list[46]) = 518;
	SvREFCNT(gv_list[46]) += 4;
	GvREFCNT(gv_list[46]) += 2;
	gv_list[47] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/FileHandle.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[47]) = 0x600d;
	GvFLAGS(gv_list[47]) = 0x2;
	GvLINE(gv_list[47]) = 56;
	SvREFCNT(gv_list[47]) += 21;
	GvREFCNT(gv_list[47]) += 2;
	xpv_list[19].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/FileHandle.pm", 34);
	GvSV(gv_list[47]) = &sv_list[24];
	GvFILE(gv_list[47]) = "/usr/lib/perl5/5.6.0/i386-linux/B/C.pm";
	gv_list[48] = gv_fetchpv("main::_<printx.pl", TRUE, SVt_PV);
	SvFLAGS(gv_list[48]) = 0x600d;
	GvFLAGS(gv_list[48]) = 0x2;
	GvLINE(gv_list[48]) = 0;
	SvREFCNT(gv_list[48]) += 5;
	GvREFCNT(gv_list[48]) += 2;
	xpv_list[20].xpv_pv = savepvn("printx.pl", 9);
	GvSV(gv_list[48]) = &sv_list[25];
	GvFILE(gv_list[48]) = "";
	gv_list[49] = gv_fetchpv("main::=", TRUE, SVt_PV);
	SvFLAGS(gv_list[49]) = 0x600d;
	GvFLAGS(gv_list[49]) = 0x2;
	GvLINE(gv_list[49]) = 489;
	SvREFCNT(gv_list[49]) += 4;
	GvREFCNT(gv_list[49]) += 2;
	gv_list[50] = gv_fetchpv("main::_<B/Section.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[50]) = 0x600d;
	GvFLAGS(gv_list[50]) = 0x2;
	GvLINE(gv_list[50]) = 3;
	SvREFCNT(gv_list[50]) += 1;
	GvREFCNT(gv_list[50]) += 2;
	xpv_list[21].xpv_pv = savepvn("B/Section.pm", 12);
	GvSV(gv_list[50]) = &sv_list[26];
	GvFILE(gv_list[50]) = "}";
	gv_list[51] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/warnings/register.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[51]) = 0x600d;
	GvFLAGS(gv_list[51]) = 0x2;
	GvLINE(gv_list[51]) = 11;
	SvREFCNT(gv_list[51]) += 16;
	GvREFCNT(gv_list[51]) += 2;
	xpv_list[22].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/warnings/register.pm", 41);
	GvSV(gv_list[51]) = &sv_list[27];
	GvFILE(gv_list[51]) = "/usr/lib/perl5/5.6.0/vars.pm";
	gv_list[52] = gv_fetchpv("main::@", TRUE, SVt_PV);
	SvFLAGS(gv_list[52]) = 0x600d;
	GvFLAGS(gv_list[52]) = 0x2;
	GvLINE(gv_list[52]) = 0;
	SvREFCNT(gv_list[52]) += 10;
	GvREFCNT(gv_list[52]) += 2;
	gv_list[53] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/vars.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[53]) = 0x600d;
	GvFLAGS(gv_list[53]) = 0x2;
	GvLINE(gv_list[53]) = 4;
	SvREFCNT(gv_list[53]) += 25;
	GvREFCNT(gv_list[53]) += 2;
	xpv_list[23].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/vars.pm", 28);
	GvSV(gv_list[53]) = &sv_list[28];
	GvFILE(gv_list[53]) = "/usr/lib/perl5/5.6.0/File/Spec.pm";
	gv_list[54] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/base.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[54]) = 0x600d;
	GvFLAGS(gv_list[54]) = 0x2;
	GvLINE(gv_list[54]) = 10;
	SvREFCNT(gv_list[54]) += 33;
	GvREFCNT(gv_list[54]) += 2;
	xpv_list[24].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/base.pm", 28);
	GvSV(gv_list[54]) = &sv_list[29];
	GvFILE(gv_list[54]) = "/usr/lib/perl5/5.6.0/i386-linux/B/C.pm";
	gv_list[55] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/Symbol.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[55]) = 0x600d;
	GvFLAGS(gv_list[55]) = 0x2;
	GvLINE(gv_list[55]) = 110;
	SvREFCNT(gv_list[55]) += 31;
	GvREFCNT(gv_list[55]) += 2;
	xpv_list[25].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/Symbol.pm", 30);
	GvSV(gv_list[55]) = &sv_list[30];
	GvFILE(gv_list[55]) = "/usr/lib/perl5/5.6.0/i386-linux/IO/File.pm";
	gv_list[56] = gv_fetchpv("main::ARGV", TRUE, SVt_PV);
	SvFLAGS(gv_list[56]) = 0x600d;
	GvFLAGS(gv_list[56]) = 0x2;
	GvLINE(gv_list[56]) = 0;
	SvREFCNT(gv_list[56]) += 1;
	GvREFCNT(gv_list[56]) += 2;
	gv_list[57] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/Exporter.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[57]) = 0x600d;
	GvFLAGS(gv_list[57]) = 0x2;
	GvLINE(gv_list[57]) = 10;
	SvREFCNT(gv_list[57]) += 174;
	GvREFCNT(gv_list[57]) += 2;
	xpv_list[26].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/Exporter.pm", 32);
	GvSV(gv_list[57]) = &sv_list[31];
	GvFILE(gv_list[57]) = "/usr/lib/perl5/5.6.0/i386-linux/B.pm";
	gv_list[58] = gv_fetchpv("attributes::bootstrap", TRUE, SVt_PV);
	SvFLAGS(gv_list[58]) = 0x600d;
	GvFLAGS(gv_list[58]) = 0x2;
	GvLINE(gv_list[58]) = 0;
	SvREFCNT(gv_list[58]) += 2;
	GvREFCNT(gv_list[58]) += 2;
	GvSV(gv_list[58]) = &sv_list[32];
	GvCV(gv_list[58]) = (CV*)(NULL);
	GvFILE(gv_list[58]) = "printx.pl";
	gv_list[59] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/Config.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[59]) = 0x600d;
	GvFLAGS(gv_list[59]) = 0x2;
	GvLINE(gv_list[59]) = 59;
	SvREFCNT(gv_list[59]) += 63;
	GvREFCNT(gv_list[59]) += 2;
	xpv_list[27].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/Config.pm", 41);
	GvSV(gv_list[59]) = &sv_list[33];
	GvFILE(gv_list[59]) = "/usr/lib/perl5/5.6.0/i386-linux/B/C.pm";
	gv_list[60] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/SelectSaver.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[60]) = 0x600d;
	GvFLAGS(gv_list[60]) = 0x2;
	GvLINE(gv_list[60]) = 111;
	SvREFCNT(gv_list[60]) += 14;
	GvREFCNT(gv_list[60]) += 2;
	xpv_list[28].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/SelectSaver.pm", 35);
	GvSV(gv_list[60]) = &sv_list[34];
	GvFILE(gv_list[60]) = "/usr/lib/perl5/5.6.0/i386-linux/IO/File.pm";
	gv_list[61] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/Cwd.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[61]) = 0x600d;
	GvFLAGS(gv_list[61]) = 0x2;
	GvLINE(gv_list[61]) = 5;
	SvREFCNT(gv_list[61]) += 133;
	GvREFCNT(gv_list[61]) += 2;
	xpv_list[29].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/Cwd.pm", 27);
	GvSV(gv_list[61]) = &sv_list[35];
	GvFILE(gv_list[61]) = "/usr/lib/perl5/5.6.0/File/Spec/Unix.pm";
	gv_list[62] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/IO.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[62]) = 0x600d;
	GvFLAGS(gv_list[62]) = 0x2;
	GvLINE(gv_list[62]) = 241;
	SvREFCNT(gv_list[62]) += 26;
	GvREFCNT(gv_list[62]) += 2;
	xpv_list[30].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/IO.pm", 37);
	GvSV(gv_list[62]) = &sv_list[36];
	GvFILE(gv_list[62]) = "/usr/lib/perl5/5.6.0/i386-linux/IO/Handle.pm";
	gv_list[63] = gv_fetchpv("main::_<perlmain.c", TRUE, SVt_PV);
	SvFLAGS(gv_list[63]) = 0x600d;
	GvFLAGS(gv_list[63]) = 0x2;
	GvLINE(gv_list[63]) = 0;
	SvREFCNT(gv_list[63]) += 1;
	GvREFCNT(gv_list[63]) += 2;
	xpv_list[31].xpv_pv = savepvn("perlmain.c", 10);
	GvSV(gv_list[63]) = &sv_list[37];
	GvFILE(gv_list[63]) = "printx.pl";
	gv_list[64] = gv_fetchpv("main::\\", TRUE, SVt_PV);
	SvFLAGS(gv_list[64]) = 0x600d;
	GvFLAGS(gv_list[64]) = 0x2;
	GvLINE(gv_list[64]) = 421;
	SvREFCNT(gv_list[64]) += 6;
	GvREFCNT(gv_list[64]) += 2;
	gv_list[65] = gv_fetchpv("main::]", TRUE, SVt_PV);
	SvFLAGS(gv_list[65]) = 0x600d;
	GvFLAGS(gv_list[65]) = 0x2;
	GvLINE(gv_list[65]) = 10;
	SvREFCNT(gv_list[65]) += 1;
	GvREFCNT(gv_list[65]) += 2;
	gv_list[66] = gv_fetchpv("main::stderr", TRUE, SVt_PV);
	SvFLAGS(gv_list[66]) = 0x600d;
	GvFLAGS(gv_list[66]) = 0x2;
	GvLINE(gv_list[66]) = 0;
	SvREFCNT(gv_list[66]) += 1;
	GvREFCNT(gv_list[66]) += 2;
	GvSV(gv_list[66]) = &sv_list[38];
	GvFILE(gv_list[66]) = "printx.pl";
	SvSTASH((IO*)&sv_list[39]) = hv0;
	GvIOp(gv_list[66]) = (IO*)&sv_list[39];
	gv_list[67] = gv_fetchpv("main::^", TRUE, SVt_PV);
	SvFLAGS(gv_list[67]) = 0x600d;
	GvFLAGS(gv_list[67]) = 0x2;
	GvLINE(gv_list[67]) = 510;
	SvREFCNT(gv_list[67]) += 4;
	GvREFCNT(gv_list[67]) += 2;
	gv_list[68] = gv_fetchpv("main::INC", TRUE, SVt_PV);
	SvFLAGS(gv_list[68]) = 0x600d;
	GvFLAGS(gv_list[68]) = 0x2;
	GvLINE(gv_list[68]) = 0;
	SvREFCNT(gv_list[68]) += 5;
	GvREFCNT(gv_list[68]) += 2;
	GvSV(gv_list[68]) = &sv_list[40];
	xpv_list[32].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux", 31);
	xpv_list[33].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux", 31);
	xpv_list[34].xpv_pv = savepvn("/usr/lib/perl5/5.6.0", 20);
	xpv_list[35].xpv_pv = savepvn("/usr/lib/perl5/site_perl/5.6.0/i386-linux", 41);
	xpv_list[36].xpv_pv = savepvn("/usr/lib/perl5/site_perl/5.6.0/i386-linux", 41);
	xpv_list[37].xpv_pv = savepvn("/usr/lib/perl5/site_perl/5.6.0", 30);
	xpv_list[38].xpv_pv = savepvn("/usr/lib/perl5/site_perl/5.6.0/i386-linux", 41);
	xpv_list[39].xpv_pv = savepvn("/usr/lib/perl5/site_perl/5.6.0", 30);
	xpv_list[40].xpv_pv = savepvn("/usr/lib/perl5/site_perl", 24);
	xpv_list[41].xpv_pv = savepvn(".", 1);
	xpv_list[42].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux", 31);
	xpv_list[43].xpv_pv = savepvn("/usr/lib/perl5/5.6.0", 20);
	xpv_list[44].xpv_pv = savepvn("/usr/lib/perl5/site_perl/5.6.0/i386-linux", 41);
	xpv_list[45].xpv_pv = savepvn("/usr/lib/perl5/site_perl/5.6.0", 30);
	xpv_list[46].xpv_pv = savepvn("/usr/lib/perl5/site_perl", 24);
	xpv_list[47].xpv_pv = savepvn(".", 1);
	{
		SV **svp;
		AV *av = (AV*)&sv_list[41];
		av_extend(av, 15);
		svp = AvARRAY(av);
		*svp++ = (SV*)&sv_list[42];
		*svp++ = (SV*)&sv_list[43];
		*svp++ = (SV*)&sv_list[44];
		*svp++ = (SV*)&sv_list[45];
		*svp++ = (SV*)&sv_list[46];
		*svp++ = (SV*)&sv_list[47];
		*svp++ = (SV*)&sv_list[48];
		*svp++ = (SV*)&sv_list[49];
		*svp++ = (SV*)&sv_list[50];
		*svp++ = (SV*)&sv_list[51];
		*svp++ = (SV*)&sv_list[52];
		*svp++ = (SV*)&sv_list[53];
		*svp++ = (SV*)&sv_list[54];
		*svp++ = (SV*)&sv_list[55];
		*svp++ = (SV*)&sv_list[56];
		*svp++ = (SV*)&sv_list[57];
		AvFILLp(av) = 15;
	}
	GvAV(gv_list[68]) = (AV*)&sv_list[41];
	GvHV(gv_list[68]) = (HV*)&sv_list[58];
	GvFILE(gv_list[68]) = "";
	gv_list[69] = gv_fetchpv("main::_", TRUE, SVt_PV);
	SvFLAGS(gv_list[69]) = 0x600d;
	GvFLAGS(gv_list[69]) = 0x2;
	GvLINE(gv_list[69]) = 0;
	SvREFCNT(gv_list[69]) += 402;
	GvREFCNT(gv_list[69]) += 2;
	gv_list[70] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/B/Asmdata.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[70]) = 0x600d;
	GvFLAGS(gv_list[70]) = 0x2;
	GvLINE(gv_list[70]) = 54;
	SvREFCNT(gv_list[70]) += 4;
	GvREFCNT(gv_list[70]) += 2;
	xpv_list[48].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/B/Asmdata.pm", 44);
	GvSV(gv_list[70]) = &sv_list[59];
	GvFILE(gv_list[70]) = "/usr/lib/perl5/5.6.0/i386-linux/B/C.pm";
	gv_list[71] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/auto/B/B.so", TRUE, SVt_PV);
	SvFLAGS(gv_list[71]) = 0x600d;
	GvFLAGS(gv_list[71]) = 0x2;
	GvLINE(gv_list[71]) = 90;
	SvREFCNT(gv_list[71]) += 1;
	GvREFCNT(gv_list[71]) += 2;
	xpv_list[49].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/auto/B/B.so", 43);
	GvSV(gv_list[71]) = &sv_list[60];
	GvFILE(gv_list[71]) = "/usr/lib/perl5/5.6.0/i386-linux/XSLoader.pm";
	gv_list[72] = gv_fetchpv("main::ENV", TRUE, SVt_PV);
	SvFLAGS(gv_list[72]) = 0x600d;
	GvFLAGS(gv_list[72]) = 0x2;
	GvLINE(gv_list[72]) = 0;
	SvREFCNT(gv_list[72]) += 59;
	GvREFCNT(gv_list[72]) += 2;
	gv_list[73] = gv_fetchpv("main::stdin", TRUE, SVt_PV);
	SvFLAGS(gv_list[73]) = 0x600d;
	GvFLAGS(gv_list[73]) = 0x2;
	GvLINE(gv_list[73]) = 0;
	SvREFCNT(gv_list[73]) += 1;
	GvREFCNT(gv_list[73]) += 2;
	GvSV(gv_list[73]) = &sv_list[61];
	GvFILE(gv_list[73]) = "printx.pl";
	SvSTASH((IO*)&sv_list[62]) = hv0;
	GvIOp(gv_list[73]) = (IO*)&sv_list[62];
	gv_list[74] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/i386-linux/Fcntl.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[74]) = 0x600d;
	GvFLAGS(gv_list[74]) = 0x2;
	GvLINE(gv_list[74]) = 54;
	SvREFCNT(gv_list[74]) += 26;
	GvREFCNT(gv_list[74]) += 2;
	xpv_list[50].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/i386-linux/Fcntl.pm", 40);
	GvSV(gv_list[74]) = &sv_list[63];
	GvFILE(gv_list[74]) = "/usr/lib/perl5/5.6.0/i386-linux/IO/Seekable.pm";
	gv_list[75] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/Exporter/Heavy.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[75]) = 0x600d;
	GvFLAGS(gv_list[75]) = 0x2;
	GvLINE(gv_list[75]) = 15;
	SvREFCNT(gv_list[75]) += 139;
	GvREFCNT(gv_list[75]) += 2;
	xpv_list[51].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/Exporter/Heavy.pm", 38);
	GvSV(gv_list[75]) = &sv_list[64];
	GvFILE(gv_list[75]) = "/usr/lib/perl5/5.6.0/Exporter.pm";
	gv_list[76] = gv_fetchpv("main::_</usr/lib/perl5/5.6.0/warnings.pm", TRUE, SVt_PV);
	SvFLAGS(gv_list[76]) = 0x600d;
	GvFLAGS(gv_list[76]) = 0x2;
	GvLINE(gv_list[76]) = 3;
	SvREFCNT(gv_list[76]) += 52;
	GvREFCNT(gv_list[76]) += 2;
	xpv_list[52].xpv_pv = savepvn("/usr/lib/perl5/5.6.0/warnings.pm", 32);
	GvSV(gv_list[76]) = &sv_list[65];
	GvFILE(gv_list[76]) = "/usr/lib/perl5/5.6.0/warnings/register.pm";
	gv_list[77] = gv_fetchpv("main::|", TRUE, SVt_PV);
	SvFLAGS(gv_list[77]) = 0x600d;
	GvFLAGS(gv_list[77]) = 0x2;
	GvLINE(gv_list[77]) = 443;
	SvREFCNT(gv_list[77]) += 5;
	GvREFCNT(gv_list[77]) += 2;
	gv_list[78] = gv_fetchpv("main::_<xsutils.c", TRUE, SVt_PV);
	SvFLAGS(gv_list[78]) = 0x600d;
	GvFLAGS(gv_list[78]) = 0x2;
	GvLINE(gv_list[78]) = 0;
	SvREFCNT(gv_list[78]) += 1;
	GvREFCNT(gv_list[78]) += 2;
	xpv_list[53].xpv_pv = savepvn("xsutils.c", 9);
	GvSV(gv_list[78]) = &sv_list[66];
	GvFILE(gv_list[78]) = "printx.pl";
	PL_main_root = (OP*)&listop_list[0];
	PL_main_start = &op_list[0];
	PL_initav = (AV *) Nullsv;
	{
		SV **svp;
		AV *av = (AV*)&sv_list[68];
		av_extend(av, 1);
		svp = AvARRAY(av);
		*svp++ = (SV*)&PL_sv_undef;
		*svp++ = (SV*)&sv_list[69];
		AvFILLp(av) = 1;
	}
	PL_curpad = AvARRAY((AV*)&sv_list[68]);
	GvHV(PL_incgv) = (HV*)&sv_list[58];
	GvAV(PL_incgv) = (AV*)&sv_list[41];
	av_store(CvPADLIST(PL_main_cv),0,SvREFCNT_inc((AV*)&sv_list[67]));
	av_store(CvPADLIST(PL_main_cv),1,SvREFCNT_inc((AV*)&sv_list[68]));
	PL_amagic_generation= 0;
	return 0;
}

int
main(int argc, char **argv, char **env)
{
    int exitstatus;
    int i;
    char **fakeargv;

    PERL_SYS_INIT3(&argc,&argv,&env);
 
    if (!PL_do_undump) {
	my_perl = perl_alloc();
	if (!my_perl)
	    exit(1);
	perl_construct( my_perl );
	PL_perl_destruct_level = 0;
    }

#ifdef CSH
    if (!PL_cshlen) 
      PL_cshlen = strlen(PL_cshname);
#endif

#ifdef ALLOW_PERL_OPTIONS
#define EXTRA_OPTIONS 2
#else
#define EXTRA_OPTIONS 3
#endif /* ALLOW_PERL_OPTIONS */
    New(666, fakeargv, argc + EXTRA_OPTIONS + 1, char *);
    fakeargv[0] = argv[0];
    fakeargv[1] = "-e";
    fakeargv[2] = "";
#ifndef ALLOW_PERL_OPTIONS
    fakeargv[3] = "--";
#endif /* ALLOW_PERL_OPTIONS */
    for (i = 1; i < argc; i++)
	fakeargv[i + EXTRA_OPTIONS] = argv[i];
    fakeargv[argc + EXTRA_OPTIONS] = 0;
    
    exitstatus = perl_parse(my_perl, xs_init, argc + EXTRA_OPTIONS,
			    fakeargv, NULL);
    if (exitstatus)
	exit( exitstatus );

    sv_setpv(GvSV(gv_fetchpv("0", TRUE, SVt_PV)), argv[0]);
    PL_main_cv = PL_compcv;
    PL_compcv = 0;

    exitstatus = perl_init();
    if (exitstatus)
	exit( exitstatus );
    dl_init(aTHX);

    exitstatus = perl_run( my_perl );

    perl_destruct( my_perl );
    perl_free( my_perl );

    PERL_SYS_TERM();

    exit( exitstatus );
}

/* yanked from perl.c */
static void
xs_init(pTHX)
{
    char *file = __FILE__;
    dTARG;
    djSP;

#ifdef USE_DYNAMIC_LOADING
	newXS("DynaLoader::boot_DynaLoader", boot_DynaLoader, file);
#endif
/* bootstrapping code*/
	SAVETMPS;
	targ=sv_newmortal();
#ifdef DYNALOADER_BOOTSTRAP
	PUSHMARK(sp);
	XPUSHp("DynaLoader",strlen("DynaLoader"));
	PUTBACK;
	boot_DynaLoader(aTHX_ NULL);
	SPAGAIN;
#endif
	FREETMPS;
/* end bootstrapping code */
}
static void
dl_init(pTHX)
{
    char *file = __FILE__;
    dTARG;
    djSP;
/* Dynamicboot strapping code*/
	SAVETMPS;
	targ=sv_newmortal();
	FREETMPS;
/* end Dynamic bootstrapping code */
}
