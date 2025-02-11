#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/types.h>


#define PATH_MAX 4096

void list_themes(char *filepath) {
    struct dirent *entry;
    DIR *dp = opendir(filepath);

    if (dp == NULL) {
        perror("Não foi possível abrir o diretório");
        return; 
    }

    printf("Temas disponíveis:\n");
    while ((entry = readdir(dp))) {
        if (entry->d_type == DT_DIR) {
            // Ignorar "." e ".."
            if (strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") != 0) {
                printf("  %s\n", entry->d_name);
            }
        }
    }

    closedir(dp);
}

void apply_theme(const char *theme_name) {

    // printf("Aplicando o tema: %s\n", theme_name);
    
    // Usar system() para executar o script de aplicação
    char change_theme[256];
    snprintf(change_theme, sizeof(change_theme), "change-theme %s", theme_name);
    system(change_theme);

    char apply_theme[256];
    snprintf(apply_theme, sizeof(apply_theme), "%s/.config/hypr/src/apply-theme.sh", getenv("HOME"));
    system(apply_theme);    
}

void show_help() {
    printf("\nUso: hypr [comando] [opções]\n\n");
    printf("   list          Lista todos os temas.\n");
    printf("   apply <nome>  Aplica o tema especificado.\n");
    printf("   -help, -h     Ajuda.\n\n");
}

int main(int argc, char *argv[]) {
    char filepath[PATH_MAX];

    /* Construct path string to get to this user's home dir */
    snprintf(filepath, PATH_MAX, "%s/.config/hypr/themes", getenv("HOME"));


    if (argc < 2) {
        show_help();
        return 1;
    }

    if (strcmp(argv[1], "list") == 0) {
        list_themes(filepath);
    }
    else if (strcmp(argv[1], "apply") == 0) {
        if (argc != 3) {
            fprintf(stderr, "Uso: %s apply <nome do tema>\n", argv[0]);
            return 1;
        }
        apply_theme(argv[2]);
    }
    else if (strcmp(argv[1], "-help") == 0 || strcmp(argv[1], "-h") == 0) {
        show_help();
        return 0;
    }
    else {
        fprintf(stderr, "\nN vai ta tendo: %s \n :(", argv[1]);
        show_help();
        return 1;
    }

    return 0;
}
