class HelloWorld {
    public static void main(String[] a){
	System.out.println(new Foo().bar());
    }
}

/* comment
   on
   many
man
y 'lin'es '*
 */

class Foo {
    int x;
    int y;
    boolean b;
    int [] arr;
    public boolean bar() {
	if (b)
	    x = x + 1;
	else 
	    while (b) x = 0;
	
	x = this.foo(x);

	return b;
    }

    public int foo(boolean bajs) {
	
	return 1;
    }
}

class Bar { }
