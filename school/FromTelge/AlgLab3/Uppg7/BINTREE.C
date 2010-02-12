#include "bintree.h"

// Prototyper ej synliga f”r anv„ndare.
void RecClearTree(Node *n);
int RecTreeHight(Node *n);
void RecTraverse(Node *np, void(*Visit)(TreeEntry));

// Funktionsdefinitioner.
void CreateTree(Tree *T) {
	*T = NULL;
}

Bool TreeEmpty(Tree T) {
	return (T == NULL);
}

Bool TreeFull(Tree T) {
	Node *tmp;
	tmp = malloc(sizeof(Node));
	if (!tmp)
		return TRUE;
	free(tmp);
	return FALSE;
}

void Insert(Tree *T, TreeEntry x) {
	Node *newnode, *nodep;
	newnode = malloc(sizeof(Node));
	if (!newnode)
		Error("Kan inte skapa ny nod");

	newnode->entry = x;
	strcpy(newnode->key, newnode->entry.lname);
	strcat(newnode->key, newnode->entry.fname);
	newnode->left = newnode->right = NULL;

	if (TreeEmpty(*T)) {
		*T = newnode;
		//printf("Insatt 1:a: %d\n", (*T)->entry);
		return;
	}

	nodep = *T;

	while (1) {
		if (strcmp(nodep->key, strcat(x.lname, x.fname)) == 0) {
			Warning("Noden finns redan");
			return;
		}
		if (strcmp(nodep->key, strcat(x.lname, x.fname)) > 0) {
			if (nodep->left)
				nodep = nodep->left;
			else {
				nodep->left = newnode;
				break;
			}
		}
		else {
			if (nodep->right)
				nodep = nodep->right;
			else {
				nodep->right = newnode;
				break;
			}
		}
	}
//	printf("L„gger till: %d\n", newnode->entry);
}

void Traverse(Tree T, void(*Visit)(TreeEntry)) {
	RecTraverse(T, Visit);
}

void RecTraverse(Node *np, void(*Visit)(TreeEntry)) {
	if (np->left)
		RecTraverse(np->left, Visit);
	if (np)
		Visit(np->entry);
	if (np->right)
		RecTraverse(np->right, Visit);
}

void ClearTree(Tree T) {
	RecClearTree(T);
}

void RecClearTree(Node *n) {
	if (n->left)
		RecClearTree(n->left);
	if (n->right)
		RecClearTree(n->right);
	free(n);
}

int TreeHight(Tree T) {
	return RecTreeHight(T);
}

int RecTreeHight(Node *n) {
	int static cnt = 0, max = 0;
	if (n->left) {
		cnt ++;
		RecTreeHight(n->left);
		if (cnt > max)
			max = cnt;
		cnt --;
	}
	if (n->right) {
		cnt ++;
		RecTreeHight(n->right);
		if (cnt > max)
			max = cnt;
		cnt --;
	}

	return max;
}