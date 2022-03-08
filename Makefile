
#Flags/Dirs
NAME=mlxstart
INC := ./includes/
SRCDIR := ./src/
OBJDIR := ./obj/
LIBS :=
CC := GCC
FLAGS := -Wall -Werror -Wextra -I$(INC) $(LIBS)

#Objects
SRC := $(wildcard $(SRCDIR)/*.c)
OBJ := $(addprefix $(OBJDIR),$(notdir $(SRC:.c=.o)))

#OS Specifics/MLX
OS := $(shell uname)
#LINUX
LINUXDIR := ./MLX_LINUX/
LINUXFLAGS := -L$(LINUXDIR) -lmlx -lXext -lX11
#MAC
MACDIR := ./MLX_MAC/
MACFLAGS := -L$(MACDIR) -lmlx -framework OpenGL -framework AppKit

ifeq ($(OS),Darwin)
	MLXDIR = $(MACDIR)
	MLXFLAGS = $(MACFLAGS)
else ifeq ($(OS),Linux)
	MLXDIR = $(LINUXDIR)
	MLXFLAGS = $(LINUXFLAGS)
else
$(error Incompatable OS Detected)
endif
MLX := $(MLXDIR)libmlx.a
FLAGS += -I$(MLXDIR)

#Make Goals
all: $(NAME)

$(NAME): $(MLX) $(OBJ)
	$(CC) $(FLAGS) $(MLXFLAGS) $(OBJ) -o $(NAME)

$(MLX):
	@make -C $(MLXDIR)

$(OBJDIR)%.o:$(SRCDIR)%.c | $(OBJDIR)
	@$(CC) $(FLAGS) -c $< -o $@

$(OBJDIR):
	@mkdir -p $(OBJDIR)

clean:
	@make clean -s -C $(MLXDIR)
	@rm -rf $(OBJDIR)

fclean: clean
	@rm -f $(NAME)

re: fclean all