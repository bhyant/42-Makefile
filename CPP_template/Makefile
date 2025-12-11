# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tbhuiyan <tbhuiyan@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/11 13:58:04 by tbhuiyan          #+#    #+#              #
#    Updated: 2025/12/11 13:59:42 by tbhuiyan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#Mettre le nom de l'executable
NAME        = 

CXX         = c++
CXXFLAGS    = -Wall -Wextra -Werror -std=c++98
DEPFLAGS    = -MMD -MP

SRC_DIR     = srcs
OBJ_DIR     = .objs
INC_DIR     = includes

INCLUDES    = -I$(INC_DIR)

#Wildcard Interdit a la norme mettre les sources manuellement
SRCS        = $(shell find $(SRC_DIR) -name '*.cpp')
OBJS        = $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
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
	@$(CXX) $(CXXFLAGS) $(OBJS) -o $(NAME)
	@echo "$(GREEN)✓ $(NAME) created$(RESET)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	@$(eval CURRENT_FILE=$(shell echo $$(($(CURRENT_FILE)+1))))
	@$(eval PERCENT=$(shell echo $$(($(CURRENT_FILE)*100/$(TOTAL_FILES)))))
	@$(eval FILLED=$(shell echo $$(($(CURRENT_FILE)*$(PROGRESS_BAR_WIDTH)/$(TOTAL_FILES)))))
	@printf "$(CYAN)[$(RESET)"
	@printf "$(GREEN)%*s" $(FILLED) | tr ' ' '='
	@printf "%*s" $$(($(PROGRESS_BAR_WIDTH)-$(FILLED))) | tr ' ' '-'
	@printf "$(CYAN)]$(RESET) $(YELLOW)%3d%%$(RESET) Compiling: $(notdir $<)   \r" $(PERCENT)
	@$(CXX) $(CXXFLAGS) $(DEPFLAGS) $(INCLUDES) -c $< -o $@

-include $(DEPS)

clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(RED)✓ Objects cleaned$(RESET)"

fclean: clean
	@rm -f $(NAME)
	@echo "$(RED)✓ Full clean done$(RESET)"

re: fclean all

.PHONY: all clean fclean re
