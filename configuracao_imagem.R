# Configuração de imagem

install.packages("renv")
renv::init()
renv::install(yaml)
renv::install(glue)
renv::snapshot()

# Para restabelecer bibliotecas:
#renv::restore() #Em config
 
