#include "mlx_start.h"
#include <stdio.h>
#include <stdlib.h>

int	main(void)
{
	void	*mlx;

	mlx = mlx_init();
	free(mlx);
	printf("MLX Successfully Loaded\n");
}