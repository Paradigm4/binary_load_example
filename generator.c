#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/* gcc -O2 -o generator generator.c
 * ./generator N start > pipe-or-file
 * where N is the number of 96 byte records to write (10 doubles 4 ints)
 * and start is the starting index of the records
 * return value 0 means success, other codes are errors:
 * 1 means invalid input
 * 2 means could not allocate memory
 * 3 means incomplete write
 */
int main(int argc, char **argv)
{
  if(argc < 2) return 1;
  int N = atoi(argv[1]);
  int start = atoi(argv[2]);
  typedef struct
  {
    double d[10];
    int i[4];
  } record;
  record *r, *x;
  r = (record *) malloc(N * sizeof(record));
  if(r == NULL) return 2;
  int j;
  x = r;
  for(j = start; j < N + start; ++j)
  {
    x->d[0] = j;
    x->d[1] = j * 2;
    x->d[2] = j - 1;
    x->d[3] = j * j;
    x->d[4] = j % 55;
    x->d[5] = j % 113;
    x->d[6] = j % 17;
    x->d[7] = j % 3;
    x->d[8] = j % 577;
    x->d[9] = j * 881;
    x->i[0] = j % 10;
    x->i[1] = j;
    x->i[2] = 17 * j % 100;
    x->i[3] = 113 * j % 100;
    ++x;
  }
  ssize_t n = write(1, r, N * sizeof(record));
  fdatasync(1);
  free(r);
  if(n != (N * sizeof(record))) return 3;
  return 0;
}
