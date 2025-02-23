#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LINE_TO_EDIT 13
#define MAX_LINE_LENGTH 1024
#define PATH_MAX 4096

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <palavra>\n", argv[0]);
        return 1;
    }

    const char *input = argv[1];
    
    char filename[PATH_MAX];
    char theme_file[PATH_MAX];

    /* Construct path string to get to this user's home dir */
    snprintf(filename, PATH_MAX, "%s/.config/hypr/hyprland.conf", getenv("HOME"));

    /* Construct path string to get to this user's home dir */
    snprintf(theme_file, PATH_MAX, "%s/.config/hypr/.theme", getenv("HOME"));

    const char *tempfile = "arquivo_temp.conf";
    
    FILE *file = fopen(filename, "r");
    FILE *temp = fopen(tempfile, "w");

    if (file == NULL || temp == NULL) {
        perror("Erro ao abrir arquivo");
        return 1;
    }

    char line[MAX_LINE_LENGTH];
    int current_line = 1;

    while (fgets(line, sizeof(line), file) != NULL) {
        if (current_line == LINE_TO_EDIT) {
            fprintf(temp, "source = ~/.config/hypr/themes/%s/hypr-config.conf\n", input);
        } else {
            fputs(line, temp);
        }
        current_line++;
    }

    fclose(file);
    fclose(temp);

    // Substitui o arquivo original pelo temporário
    if (remove(filename) != 0 || rename(tempfile, filename) != 0) {
        perror("Erro ao renomear arquivo");
        return 1;
    }

    FILE *theme = fopen(theme_file, "w");
    if (theme == NULL) {
        perror("Erro ao abrir o arquivo .theme");
        return 1;
    }

    // Escreve o input no arquivo ".theme"
    fprintf(theme, "%s\n", input);
    fclose(theme);

    printf("Arquivo editado com sucesso!\n");
    return 0;
}
