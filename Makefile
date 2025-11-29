# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tbhuiyan <tbhuiyan@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/29 18:47:23 by tbhuiyan          #+#    #+#              #
#    Updated: 2025/11/29 18:49:46 by tbhuiyan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#Mettre le nom de l'executable
NAME        = 

CC          = cc
CFLAGS      = -Wall -Wextra -Werror
DEPFLAGS    = -MMD -MP

SRC_DIR     = src
OBJ_DIR     = .objs
INC_DIR     = includes

INCLUDES    = -I$(INC_DIR)

#Wildcard Interdit a la norme mettre les sources manuellement
SRCS        = $(wildcard $(SRC_DIR)/*.c)
OBJS        = $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
DEPS        = $(OBJS:.o=.d)

RED         = \033[0;31m
GREEN       = \033[0;32m
YELLOW      = \033[0;33m
CYAN        = \033[0;36m
RESET       = \033[0m

PROGRESS_BAR_WIDTH = 50
TOTAL_FILES = $(words $(OBJS))
CURRENT_FILE = 0

all: $(NAME)

$(NAME): $(OBJS)
	@echo ""
	@$(CC) $(CFLAGS) $(OBJS) -o $(NAME)
	@echo "$(GREEN)✓ $(NAME) created$(RESET)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	@$(eval CURRENT_FILE=$(shell echo $$(($(CURRENT_FILE)+1))))
	@$(eval PERCENT=$(shell echo $$(($(CURRENT_FILE)*100/$(TOTAL_FILES)))))
	@$(eval FILLED=$(shell echo $$(($(CURRENT_FILE)*$(PROGRESS_BAR_WIDTH)/$(TOTAL_FILES)))))
	@printf "$(CYAN)[$(RESET)"
	@printf "$(GREEN)%*s" $(FILLED) | tr ' ' '='
	@printf "%*s" $$(($(PROGRESS_BAR_WIDTH)-$(FILLED))) | tr ' ' '-'
	@printf "$(CYAN)]$(RESET) $(YELLOW)%3d%%$(RESET) Compiling: $(notdir $<)   \r" $(PERCENT)
	@$(CC) $(CFLAGS) $(DEPFLAGS) $(INCLUDES) -c $< -o $@

-include $(DEPS)

clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(RED)✓ Objects cleaned$(RESET)"

fclean: clean
	@rm -f $(NAME)
	@echo "$(RED)✓ Full clean done$(RESET)"

re: fclean all

.PHONY: all clean fclean re
