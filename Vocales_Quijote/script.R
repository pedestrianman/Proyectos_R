library('stringr')
library('dplyr')
library('tidyr')
library('word.alignment')
options(warn=-1) #Warnings off

setwd("") #Directorio de Trabajo
book = file('Don_Quijote')
libro_lines = readLines(book)
libro_words = paste(libro_lines, collapse = " ")
libro_words = strsplit(libro_words,split = " ") %>% unlist()
libro_words = unique(libro_words)


VowelCount <- str_count(libro_words, pattern = "[AEIOUaeiou]")
OutputStrings <- libro_words[VowelCount >= 5]

for (i in 1:length(OutputStrings)) {
  OutputStrings[i] = tolower(OutputStrings[i]) #Vocales a consonantes
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
write.csv(Palabras_Con_5Vocales, 'Palabras.csv')

