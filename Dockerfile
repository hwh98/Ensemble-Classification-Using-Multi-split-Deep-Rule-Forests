# Base R image
FROM rocker/r-ver

# Make a directory in the container
RUN mkdir /home/r-environment

# Install R dependencies
RUN R -e "install.packages(c('dplyr', 'gapminder'))"

# Copy the algorithm R file and data to the container
COPY src/ ./src/
COPY data/ ./data/

# Run the R script
CMD R -e "source('/home/r-environment/script.R')"