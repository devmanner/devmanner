#ifndef BINTREE_H
#define BINTREE_H

#include "common.h"

typedef struct {
	char fname[20];
	char lname[20];
	int ac;
	long int tpn;
} TreeEntry;

typedef char KeyType[40];

typedef struct node {
	struct node *left, *right;
	TreeEntry entry;
	KeyType key;
} Node;

typedef Node *Tree;

void CreateTree(Tree *T);
Bool TreeEmpty(Tree T);
Bool TreeFull(Tree T);
void Insert(Tree *T, TreeEntry x);
void Traverse(Tree T, void(*Visit)(TreeEntry));
void ClearTree(Tree T);
int TreeHight(Tree T);

#endif
