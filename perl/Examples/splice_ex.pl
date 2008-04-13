#!/usr/local/bin/perl

# Satt elementen till 1, 2, 3, .... 20
@lista = 0..20;

#@lista =
splice(@lista, 5, 1);


foreach $item (@lista)
	{print "$item\n";}
