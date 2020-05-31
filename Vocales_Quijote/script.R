library('stringr')
library('dplyr')
library('tidyr')
library('word.alignment')
options(warn=-1) #Warnings off

setwd("/home/inaki/Desktop/Hilos_Cuartentena/Vocales_Quijote") #
book = file('Don_Quijote')
libro_lines = readLines(book)
libro_words = paste(libro_lines, collapse = " ")
libro_words = strsplit(libro_words,split = " ") %>% unlist()
libro_words = unique(libro_words)


VowelCount <- str_count(libro_words, pattern = "[AEIOUaeiou]")
OutputStrings <- libro_words[VowelCount >= 5]

for (i in 1:length(OutputStrings)) {
  OutputStrings[i] = tolower(OutputStrings[i]) #Las vocales las paso a consonantes
}
Index = NULL

for (i in 1:length(OutputStrings)) {
    
  Dim = unlist(strsplit(gsub("[^aeiou]", "", OutputStrings[i]),"")) %>% unique() %>% length()
  if(Dim == 5){
    Index = rbind(Index,i)
  }
}
Palabras_Con_5Vocales = OutputStrings[Index]
length(Palabras_Con_5Vocales)

Palabras_Con_5Vocales = as.data.frame(Palabras_Con_5Vocales)
colnames(Palabras_Con_5Vocales) = 'Palabra'

write.csv(Palabras_Con_5Vocales, 'Palabras.csv')

