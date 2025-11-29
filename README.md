# 🚀 Makefile Universel - École 42

Un Makefile moderne et optimisé pour tous vos projets à l'École 42, avec barre de chargement, gestion automatique des dépendances et respect des normes.

![42](https://img.shields.io/badge/42-School-000000?style=for-the-badge&logo=42&logoColor=white)
![C](https://img.shields.io/badge/C-00599C?style=for-the-badge&logo=c&logoColor=white)
![Make](https://img.shields.io/badge/Make-6D00CC?style=for-the-badge&logo=gnu&logoColor=white)

## ✨ Fonctionnalités

- ✅ **Conforme aux exigences 42** : règles `all`, `clean`, `fclean`, `re`
- 📊 **Barre de progression** colorée et informative
- 🔄 **Gestion automatique des dépendances** avec fichiers `.d`
- 🎨 **Interface colorée** pour une meilleure lisibilité
- ⚡ **Recompilation intelligente** : seuls les fichiers modifiés sont recompilés
- 🗂️ **Organisation propre** : séparation `src/`, `.objs/`, `includes/`

## 📋 Prérequis

- `gcc` ou `cc`
- `make`
- Système Unix/Linux

## 🎯 Installation

### Méthode 1 : Copie directe

```bash
# Téléchargez le Makefile
curl -O https://raw.githubusercontent.com/bhyant/makefile-42/main/Makefile

# Adaptez les variables à votre projet
```

### Méthode 2 : Clone du repo

```bash
git clone https://github.com/VOTRE_USERNAME/makefile-42.git
cd makefile-42
cp Makefile /path/to/your/project/
```

## 🛠️ Configuration

### Structure du projet

Organisez vos fichiers comme suit :

```
votre_projet/
├── Makefile
├── includes/
│   ├── header1.h
│   └── header2.h
├── srcs
│   ├── main.c
│   ├── utils.c
│   └── parsing.c
└── .objs/          (généré automatiquement)
    ├── main.o
    ├── main.d
    └── ...
```

### Variables à modifier

Ouvrez le `Makefile` et personnalisez ces variables :

```makefile
NAME        = program          # Nom de votre exécutable
SRC_DIR     = src             # Dossier des sources
OBJ_DIR     = .objs             # Dossier des objets (auto-créé)
INC_DIR     = includes        # Dossier des headers
```

## 🎮 Utilisation

### Commandes de base

```bash
make           # Compile le projet
make clean     # Supprime les fichiers objets (.o et .d)
make fclean    # Supprime tout (objets + exécutable)
make re        # Recompile entièrement (fclean + all)
```

### Barre de progression

Lors de la compilation, vous verrez :

```
[====================------------------------------] 40% Compiling: utils.c
```

Couleurs :
- 🟢 **Vert** : progression de la barre
- 🔵 **Cyan** : bordures
- 🟡 **Jaune** : pourcentage

## 🔍 Fonctionnement des dépendances (.d)

### Pourquoi les fichiers .d ?

Les fichiers `.d` permettent au Makefile de détecter automatiquement quand recompiler un fichier.

**Exemple :**

```
src/main.c inclut includes/utils.h
│
├─ Sans .d : Vous modifiez utils.h
│  └─ make → "Rien à faire" ❌ BUG !
│
└─ Avec .d : Vous modifiez utils.h
   └─ make → "Recompilation de main.o" ✅
```

### Comment ça marche ?

1. **Génération automatique** : Le flag `-MMD -MP` génère un fichier `.d` pour chaque `.o`
2. **Contenu d'un .d** :
   ```makefile
   obj/main.o: src/main.c includes/utils.h includes/libft.h
   ```
3. **Inclusion** : La ligne `-include $(DEPS)` lit tous les `.d`
4. **Recompilation intelligente** : Make sait qu'un changement dans `utils.h` nécessite de recompiler `main.o`

## 🎨 Personnalisation

### Ajouter des flags de compilation

```makefile
CFLAGS = -Wall -Wextra -Werror
CFLAGS += -g3                    # Symboles de debug
CFLAGS += -fsanitize=address     # Détection de leaks
```

### Ajouter des bibliothèques

Pour des projets comme `minishell` ou `pipex` :

```makefile
LIBS = -lreadline
# ou
LIBS = -L/path/to/lib -lft

$(NAME): $(OBJS)
    @$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $(NAME)
```

### Modifier les couleurs

```makefile
RED    = \033[0;31m
GREEN  = \033[0;32m
YELLOW = \033[0;33m
CYAN   = \033[0;36m
RESET  = \033[0m
```

### Changer la largeur de la barre

```makefile
PROGRESS_BAR_WIDTH = 50    # Modifiez cette valeur
```

## 📚 Exemples d'adaptation

### Pour Libft

```makefile
NAME = libft.a

$(NAME): $(OBJS)
    @ar rcs $(NAME) $(OBJS)
    @ranlib $(NAME)
```

### Pour Minishell

```makefile
NAME = minishell
LIBS = -lreadline

$(NAME): $(OBJS)
    @$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $(NAME)
```

### Pour FdF / So_long

```makefile
NAME = fdf
MLX_DIR = minilibx-linux
MLX = $(MLX_DIR)/libmlx.a
LIBS = -L$(MLX_DIR) -lmlx -lXext -lX11 -lm
INCLUDES = -I$(INC_DIR) -I$(MLX_DIR)

$(NAME): $(MLX) $(OBJS)
    @$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o $(NAME)

$(MLX):
    @make -C $(MLX_DIR)
```

## 🧪 Tests et debug

### Afficher les variables

Ajoutez cette règle pour débugger :

```makefile
debug:
    @echo "NAME:  $(NAME)"
    @echo "SRCS:  $(SRCS)"
    @echo "OBJS:  $(OBJS)"
    @echo "DEPS:  $(DEPS)"

.PHONY: debug
```

### Vérifier les dépendances

```bash
# Voir le contenu d'un fichier .d
cat obj/main.d
```

## 📖 Explication technique

### Flags de dépendances

```makefile
DEPFLAGS = -MMD -MP
```

- **`-MMD`** : Génère les fichiers `.d` avec les dépendances des headers
- **`-MP`** : Ajoute des règles "fantômes" pour éviter les erreurs si un header est supprimé

### Inclusion des dépendances

```makefile
-include $(DEPS)
```

- Le `-` ignore les erreurs si les `.d` n'existent pas encore (première compilation)
- Inclut tous les fichiers `.d` dans le Makefile
- Permet à Make de connaître toutes les dépendances header

### Pattern rules

```makefile
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
```

- `%` : wildcard qui capture le nom du fichier
- `$<` : le fichier source (prerequisite)
- `$@` : le fichier cible (target)

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :

1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📝 Licence

Ce projet est sous licence MIT. Utilisez-le librement pour vos projets 42 !

## 👨‍💻 Auteur

Créé pour la communauté de l'École 42

## 🙏 Remerciements

- École 42 pour la pédagogie par projets
- La communauté 42 pour le partage de connaissances
- GNU Make documentation

---

⭐ Si ce Makefile vous a été utile, n'hésitez pas à lui donner une étoile !

🐛 Vous avez trouvé un bug ? Ouvrez une [issue](https://github.com/bhyant/makefile-42/issues) !
