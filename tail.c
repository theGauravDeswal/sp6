#include <stdio.h>
#include <stdlib.h>

int main() 
{
    // Create the file "inputtext.txt" and write some lines of English text to it
    FILE *fp = fopen("inputtext.txt", "w");
    if (fp == NULL) 
    {
        printf("\nCaution: Error opening file.\n");
        return 1;
    }

    fprintf(fp, "Line 1: My name is Goku\n");
    fprintf(fp, "Line 2: My name is Vegita\n");
    fprintf(fp, "Line 3: My name is Gohan\n");
    fprintf(fp, "Line 4: My name is Trunks\n");
    fprintf(fp, "Line 5: My name is Lord Beerus\n");
    fprintf(fp, "Line 6: My name is Goku\n");
    fprintf(fp, "Line 7: My name is Vegita\n");
    fprintf(fp, "Line 8: My name is Gohan\n");
    fprintf(fp, "Line 9: My name is Trunks\n");
    fprintf(fp, "Line 10: My name is Lord Beerus\n");
    fprintf(fp, "Line 11: My name is Goku\n");
    fprintf(fp, "Line 12: My name is Vegita\n");
    fprintf(fp, "Line 13: My name is Gohan\n");
    fprintf(fp, "Line 14: My name is Trunks\n");
    fprintf(fp, "Line 15: My name is Lord Beerus\n");    

    fclose(fp);

    // Read the input 'n' from the user
    int n;

    printf("Enter the number of lines (last) to print: ");
    scanf("%d", &n);

    if (n <= 0) {
        printf("\nCaution! Abey Ghochu, positive number daal\n");
        return 1;
    }

    // Open the file "text.txt" to read its content
    fp = fopen("inputtext.txt", "r");
    if (fp == NULL) 
    {
        printf("\nCaution: Error opening file.\n");
        return 1;
    }

    // Read the file and store the last 'n' lines in an array
    char lines[n][1000];
    int lineCount = 0;
    while (fgets(lines[lineCount], sizeof(lines[lineCount]), fp) != NULL) 
    {
        lineCount++;
        if (lineCount >= n) {
            lineCount = 0; // Wrap around the array to store only the last 'n' lines
        }
    }

    // Print the last 'n' lines stored in the array
    for (int i = 0; i < n; i++) 
    {
        printf("%s", lines[lineCount]);
        lineCount = (lineCount + 1) % n;
    }

    fclose(fp);
    return 0;
}