#!/usr/local/bin/perl

@lista2[0] = "första i 2:an";

@lista1 = ("1", "2", "3", "4", "5");
@lista2 = @lista1;


foreach $item (@lista2)
	{print "$item\n";}
