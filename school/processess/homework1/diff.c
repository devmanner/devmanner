



void diff() {
  line1 = read(file1);
  line2 = read(file2);
  if (!line1 && !line2)
    return;
  else if (!line1)
    print(line2);
  else if (!line2)
    print(line1);
  else if (line1 != line2)
    print(differance(line1, line2));
}

process read1() {
  < await(!line1); line1 = read(file1); >
}
process read2() {
  < await(!line2); line2 = read(file2); >
}

process diff() {
  < await(line1); buff1 = line1; line1 = 0; >
  < await(line2); buff2 = line2; line2 = 0; >
  print(diff(buff1, buff2));
}
