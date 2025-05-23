////
////  File.swift
////  CustomComponentsSDK
////
////  Created by Alessandro Comparini on 21/05/25.
////
//
//import Foundation
//
//
//
///*
//-- CENÁRIO 1 -----------------------------------------------------------------------------------------------------
//    - [CENTAVOS]
//    - UNIDADE
//    - DEZENA COMPOSTA
//    - DEZENA
//    - DEZENA E UNIDADE
//*/
//print(SpokenCurrencyParser.parse("tres centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("doze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cinquenta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("sessenta e três centavos") ?? "erro")
//
///*
//-- CENÁRIO 2 -----------------------------------------------------------------------------------------------------
//    [REAIS] - [CENTAVOS]
//    UNIDADE - UNIDADE
//    UNIDADE - DEZENA COMPOSTA
//    UNIDADE - DEZENA
//    UNIDADE - DEZENA E UNIDADE
//*/
//
//// UNIDADE - UNIDADE
//print("RESPOSTA: 1.02")
//print(SpokenCurrencyParser.parse("um real e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("um real e dois") ?? "erro")
//print(SpokenCurrencyParser.parse("um e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("um e dois") ?? "erro")
//
//// UNIDADE - UNIDADE
//print("RESPOSTA: 8.04")
//print(SpokenCurrencyParser.parse("oito reais e zero quatro centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("oito reais e quatro") ?? "erro")
//print(SpokenCurrencyParser.parse("oito e zero quatro centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("oito e quatro") ?? "erro")
//
//// UNIDADE - DEZENA COMPOSTA
//print("RESPOSTA: 2.12")
//print(SpokenCurrencyParser.parse("dois reais e doze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("dois reais e doze") ?? "erro")
//print(SpokenCurrencyParser.parse("dois e doze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("dois e doze") ?? "erro")
//
//// UNIDADE - DEZENA
//print("RESPOSTA: 5.5")
//print(SpokenCurrencyParser.parse("cinco reais e cinquenta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cinco reais e cinquenta") ?? "erro")
//print(SpokenCurrencyParser.parse("cinco e cinquenta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cinco e cinquenta") ?? "erro")
//
//// UNIDADE - DEZENA E UNIDADE
//print("RESPOSTA: 9.63")
//print(SpokenCurrencyParser.parse("nove reais e sessenta e três centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("nove reais e sessenta e três") ?? "erro")
//print(SpokenCurrencyParser.parse("nove e sessenta e três centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("nove e sessenta e três") ?? "erro")
//
//
//
///*
//-- CENÁRIO 3 -----------------------------------------------------------------------------------------------------
//    [REAIS]         - [CENTAVOS]
//    DEZENA COMPOSTA - UNIDADE
//    DEZENA COMPOSTA - DEZENA COMPOSTA
//    DEZENA COMPOSTA - DEZENA
//    DEZENA COMPOSTA - DEZENA E UNIDADE
// 
//*/
//
//print("RESPOSTA: 11.01")
//print(SpokenCurrencyParser.parse("onze reais e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("onze reais e um") ?? "erro")
//print(SpokenCurrencyParser.parse("onze e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("onze e um") ?? "erro")
//
//print("RESPOSTA: 13.15")
//print(SpokenCurrencyParser.parse("treze reais e quinze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("treze reais e quinze") ?? "erro")
//print(SpokenCurrencyParser.parse("treze e quinze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("treze e quinze") ?? "erro")
//
//print("RESPOSTA: 13.19")
//print(SpokenCurrencyParser.parse("treze reais e dezenove centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("treze reais e dezenove") ?? "erro")
//print(SpokenCurrencyParser.parse("treze e dezenove centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("treze e dezenove") ?? "erro")
//
//print("RESPOSTA: 14.3")
//print(SpokenCurrencyParser.parse("catorze reais e trinta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("catorze reais e trinta") ?? "erro")
//print(SpokenCurrencyParser.parse("catorze e trinta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("catorze e trinta") ?? "erro")
//
//print("RESPOSTA: 17.98")
//print(SpokenCurrencyParser.parse("dezessete reais e noventa e oito centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("dezessete reais e noventa e oito") ?? "erro")
//print(SpokenCurrencyParser.parse("dezessete e noventa e oito centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("dezessete e noventa e oito") ?? "erro")
//
//
///*
//-- CENÁRIO 4 -----------------------------------------------------------------------------------------------------
//    [REAIS]- [CENTAVOS]
//    DEZENA - UNIDADE
//    DEZENA - DEZENA COMPOSTA
//    DEZENA - DEZENA
//    DEZENA - DEZENA E UNIDADE
//*/
//
//// DEZENA - UNIDADE
//print("RESPOSTA: 30.04")
//print(SpokenCurrencyParser.parse("trinta reais e quatro centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta reais e quatro") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta e quatro centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta e quatro") ?? "erro")
//
//// DEZENA - DEZENA COMPOSTA
//print("RESPOSTA: 44.17")
//print(SpokenCurrencyParser.parse("quarenta reais e dezessete centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("quarenta reais e dezessete") ?? "erro")
//print(SpokenCurrencyParser.parse("quarenta e dezessete centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("quarenta e dezessete") ?? "erro")
//
//// DEZENA - DEZENA
//print("RESPOSTA: 50.8")
//print(SpokenCurrencyParser.parse("cinquenta reais e oitenta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cinquenta reais e oitenta") ?? "erro")
//print(SpokenCurrencyParser.parse("cinquenta e oitenta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cinquenta e oitenta") ?? "erro")
//
//// DEZENA - DEZENA E UNIDADE
//print("RESPOSTA: 20.22")
//print(SpokenCurrencyParser.parse("vinte reais e vinte e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("vinte reais e vinte e dois") ?? "erro")
//print(SpokenCurrencyParser.parse("vinte e vinte e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("vinte e vinte e dois") ?? "erro")
//
//print("RESPOSTA: 30.42")
//print(SpokenCurrencyParser.parse("trinta reais e quarenta e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta reais e quarenta e dois") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta e quarenta e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta e quarenta e dois") ?? "erro")
//
//
//
///*
//-- CENÁRIO 5 -----------------------------------------------------------------------------------------------------
//    [REAIS]          - [CENTAVOS]
//    DEZENA E UNIDADE - UNIDADE
//    DEZENA E UNIDADE - DEZENA COMPOSTA
//    DEZENA E UNIDADE - DEZENA
//    DEZENA E UNIDADE - DEZENA E UNIDADE
//*/
//
//// DEZENA E UNIDADE - UNIDADE
//print("RESPOSTA: 94.01")
//print(SpokenCurrencyParser.parse("noventa e quatro reais e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("noventa e quatro reais e um") ?? "erro")
//print(SpokenCurrencyParser.parse("noventa e quatro e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("noventa e quatro e um") ?? "erro")
//
//// DEZENA E UNIDADE - DEZENA COMPOSTA
//print("RESPOSTA: 35.13")
//print(SpokenCurrencyParser.parse("trinta e cinco reais e treze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta e cinco reais e treze") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta e cinco e treze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trinta e cinco e treze") ?? "erro")
//
//// DEZENA E UNIDADE - DEZENA
//print("RESPOSTA: 59.20")
//print(SpokenCurrencyParser.parse("cinquenta e nove reais e vinte centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cinquenta e nove reais e vinte") ?? "erro")
//print(SpokenCurrencyParser.parse("cinquenta e nove e vinte centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cinquenta e nove e vinte") ?? "erro")
//
//// DEZENA E UNIDADE - DEZENA E UNIDADE
//print("RESPOSTA: 99.42")
//print(SpokenCurrencyParser.parse("noventa e nove reais e quarenta e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("noventa e nove reais e quarenta e dois") ?? "erro")
//print(SpokenCurrencyParser.parse("noventa e nove e quarenta e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("noventa e nove e quarenta e dois") ?? "erro")
//
//
//
///*
//-- CENÁRIO 6 -----------------------------------------------------------------------------------------------------
//    [REAIS]  - [CENTAVOS]
//    CENTENAS - UNIDADE
//    CENTENAS - DEZENA COMPOSTA
//    CENTENAS - DEZENA
//    CENTENAS - DEZENA E UNIDADE
//*/
//
//// CENTENAS - UNIDADE
//print("RESPOSTA: 100.01")
//print(SpokenCurrencyParser.parse("cem reais e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("cem reais e um") ?? "erro")
//print(SpokenCurrencyParser.parse("cem e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("cem e um") ?? "erro")
//
//// CENTENAS - DEZENA COMPOSTA
//print("RESPOSTA: 100.14")
//print(SpokenCurrencyParser.parse("cem reais e quatorze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cem reais e quatorze") ?? "erro")
//print(SpokenCurrencyParser.parse("cem e quatorze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cem e quatorze") ?? "erro")
//
//// CENTENAS - DEZENA
//print("RESPOSTA: 200.30")
//print(SpokenCurrencyParser.parse("duzentos reais e trinta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("duzentos reais e trinta") ?? "erro")
//print(SpokenCurrencyParser.parse("duzentos e trinta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("duzentos e trinta") ?? "erro")
//
//// CENTENAS - DEZENA E UNIDADE
//print("RESPOSTA: 500.26")
//print(SpokenCurrencyParser.parse("quinhentos reais e vinte seis centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("quinhentos reais e vinte seis") ?? "erro")
//print(SpokenCurrencyParser.parse("quinhentos e vinte seis centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("quinhentos e vinte seis") ?? "erro")
//
///*
//    [REAIS]  - [CENTAVOS]
//    CENTENAS E UNIDADE - UNIDADE
//    CENTENAS E UNIDADE - DEZENA COMPOSTA
//    CENTENAS E UNIDADE - DEZENA
//    CENTENAS E UNIDADE - DEZENA E UNIDADE
//*/
//
//// CENTENAS E UNIDADE - UNIDADE
//print("RESPOSTA: 101.01")
//print(SpokenCurrencyParser.parse("cento e um real e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e um real e um") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e um e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e um e um") ?? "erro")
//
//// CENTENAS E UNIDADE - DEZENA COMPOSTA
//print("RESPOSTA: 102.13")
//print(SpokenCurrencyParser.parse("cento e dois reais e treze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e dois reais e treze") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e dois e treze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e dois e treze") ?? "erro")
//
//// CENTENAS E UNIDADE - DEZENA
//print("RESPOSTA: 109.2")
//print(SpokenCurrencyParser.parse("cento e nove reais e vinte centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e nove reais e vinte") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e nove e vinte centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e nove e vinte") ?? "erro")
//
//// CENTENAS E UNIDADE - DEZENA E UNIDADE
//print("RESPOSTA: 107.33")
//print(SpokenCurrencyParser.parse("cento e sete real e trinta e tres centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e sete real e trinta e tres") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e sete e trinta e tres centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e sete e trinta e tres") ?? "erro")
//
//
///*
//    [REAIS]  - [CENTAVOS]
//    CENTENAS E DEZENAS COMPOSTA - UNIDADE
//    CENTENAS E DEZENAS COMPOSTA - DEZENA COMPOSTA
//    CENTENAS E DEZENAS COMPOSTA - DEZENA
//    CENTENAS E DEZENAS COMPOSTA - DEZENA E UNIDADE
// */
//
//// CENTENAS E DEZENAS COMPOSTA - UNIDADE
//print("RESPOSTA: 110.01")
//print(SpokenCurrencyParser.parse("cento e dez reais e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e dez reais e um") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e dez e um centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e dez e um") ?? "erro")
//
//print("RESPOSTA: 111.09")
//print(SpokenCurrencyParser.parse("cento e onze reais e nove centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e onze reais e nove") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e onze e nove centavo") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e onze e nove") ?? "erro")
//
//
//// CENTENAS E DEZENAS COMPOSTA - DEZENA COMPOSTA
//print("RESPOSTA: 113.13")
//print(SpokenCurrencyParser.parse("cento e treze reais e treze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e treze reais e treze") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e treze e treze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e treze e treze") ?? "erro")
//
//// CENTENAS E DEZENAS COMPOSTA - DEZENA
//print("RESPOSTA: 315.9")
//print(SpokenCurrencyParser.parse("trezentos e quinze reais e noventa centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trezentos e quinze reais e noventa") ?? "erro")
//print(SpokenCurrencyParser.parse("trezentos e quinze e noventa centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trezentos e quinze e noventa") ?? "erro")
//
//// CENTENAS E DEZENAS COMPOSTA - DEZENA E UNIDADE
//print("RESPOSTA: 511.77")
//print(SpokenCurrencyParser.parse("quinhentos e onze reais e setenta e sete centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("quinhentos e onze reais e setenta e sete") ?? "erro")
//print(SpokenCurrencyParser.parse("quinhentos e onze e setenta e sete centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("quinhentos e onze e setenta e sete") ?? "erro")
//
//
///*
//    [REAIS]  - [CENTAVOS]
//    CENTENAS E DEZENAS - UNIDADE
//    CENTENAS E DEZENAS - DEZENA COMPOSTA
//    CENTENAS E DEZENAS - DEZENA
//    CENTENAS E DEZENAS - DEZENA E UNIDADE
//*/
//
//// CENTENAS E DEZENAS - UNIDADE
//print("RESPOSTA: 140.04")
//print(SpokenCurrencyParser.parse("cento e quarenta reais e quatro centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e quarenta reais e quatro") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e quarenta e quatro centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e quarenta e quatro") ?? "erro")
//
//// CENTENAS E DEZENAS - DEZENA COMPOSTA
//print("RESPOSTA: 190.19")
//print(SpokenCurrencyParser.parse("cento e noventa reais e dezenove centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e noventa reais e dezenove") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e noventa e dezenove centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e noventa e dezenove") ?? "erro")
//
//// CENTENAS E DEZENAS - DEZENA
//print("RESPOSTA: 250.30")
//print(SpokenCurrencyParser.parse("duzentos e cinquenta reais e trinta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("duzentos e cinquenta reais e trinta") ?? "erro")
//print(SpokenCurrencyParser.parse("duzentos e cinquenta e trinta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("duzentos e cinquenta e trinta") ?? "erro")
//
//// CENTENAS E DEZENAS - DEZENA E UNIDADE
//print("RESPOSTA: 970.59")
//print(SpokenCurrencyParser.parse("novecentos e setenta reais e cinquenta e nove centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("novecentos e setenta reais e cinquenta e nove") ?? "erro")
//print(SpokenCurrencyParser.parse("novecentos e setenta e cinquenta e nove centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("novecentos e setenta e cinquenta e nove") ?? "erro")
//
//
///*
//    [REAIS]                      - [CENTAVOS]
//    CENTENAS E DEZENAS E UNIDADE - UNIDADE
//    CENTENAS E DEZENAS E UNIDADE - DEZENA COMPOSTA
//    CENTENAS E DEZENAS E UNIDADE - DEZENA
//    CENTENAS E DEZENAS E UNIDADE - DEZENA E UNIDADE
//*/
//
//// CENTENAS E DEZENAS E UNIDADE - UNIDADE
//print("RESPOSTA: 141.04")
//print(SpokenCurrencyParser.parse("cento e quarenta e um reais e quatro centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e quarenta e um reais e quatro") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e quarenta e um e quatro centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("cento e quarenta e um e quatro") ?? "erro")
//
//// CENTENAS E DEZENAS E UNIDADE - DEZENA COMPOSTA
//print("RESPOSTA: 399.1")
//print(SpokenCurrencyParser.parse("trezentos e noventa e nove reais e dez centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trezentos e noventa e nove reais e dez") ?? "erro")
//print(SpokenCurrencyParser.parse("trezentos e noventa e nove e dez centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("trezentos e noventa e nove e dez") ?? "erro")
//
//// CENTENAS E DEZENAS E UNIDADE - DEZENA COMPOSTA
//print("RESPOSTA: 639.14")
//print(SpokenCurrencyParser.parse("seiscentos e trinta e nove reais e quatorze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("seiscentos e trinta e nove reais e quatorze") ?? "erro")
//print(SpokenCurrencyParser.parse("seiscentos e trinta e nove e quatorze centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("seiscentos e trinta e nove e quatorze") ?? "erro")
//
//
//// CENTENAS E DEZENAS E UNIDADE - DEZENA
//print("RESPOSTA: 823.8")
//print(SpokenCurrencyParser.parse("oitocentos e vinte e três reais e oitenta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("oitocentos e vinte e três reais e oitenta") ?? "erro")
//print(SpokenCurrencyParser.parse("oitocentos e vinte e três e oitenta centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("oitocentos e vinte e três e oitenta") ?? "erro")
//
//// CENTENAS E DEZENAS E UNIDADE - DEZENA E UNIDADE
//print("RESPOSTA: 977.22")
//print(SpokenCurrencyParser.parse("novecentos e setenta e sete reais e vinte e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("novecentos e setenta e sete reais e vinte e dois") ?? "erro")
//print(SpokenCurrencyParser.parse("novecentos e setenta e sete e vinte e dois centavos") ?? "erro")
//print(SpokenCurrencyParser.parse("novecentos e setenta e sete e vinte e dois") ?? "erro")
//


/*

Informação que precisa ser analisadas:

 
//-- CENÁRIO 0 ---------------------------------------
//    [REAIS]
//    UNIDADE
//    DEZENA COMPOSTA
//    DEZENA UNIDADE
//    CENTENA
//    CENTENA UNIDADE
//    CENTENA DEZENA COMPOSTA
//    CENTENA DEZENA
//    CENTENA DEZENA UNIDADE
 - tem escrito real/reais:
    - tudo que tiver antes é real
    - tudo que tiver dps é centavo, estando ou não escrito a palavra centavo ou centavos
 
 
 
 
 //-- CENÁRIO 1 ---------------------------------------
 //    - [CENTAVOS]
 //    - UNIDADE
 //    - DEZENA COMPOSTA
 //    - DEZENA
 //    - DEZENA E UNIDADE
 - não tem escrito real/reais e está escrito a palavra centavo/centavos:
    - se for menor ou igual a 99 é centavo puro e pronto
    - se tiver a palavra cem e alguma coisa, com certeza é 100 reais e o resto é centavo e caso o resto for maior que 99 gerar erro.
        -> Exemplo de erro: cem e duzento e vinte cinco
        -> Exemplo de acerto: cem e trinta e cinco = 100.35
        -> Exemplo de acerto: cem e cinco = 100.05
    - se for maior que 99 e não tiver a palavra cem, seguir para o trecho abaixo que não importa se está escrito ou nao as palavras real/reais ou centavo(s) etc

 
 
 //-- CENÁRIO 0 ---------------------------------------
 //    [REAIS]
 //    UNIDADE
 //    DEZENA COMPOSTA
 //    DEZENA
 //    DEZENA UNIDADE
 //    CENTENA
 //    CENTENA UNIDADE
 //    CENTENA DEZENA COMPOSTA
 //    CENTENA DEZENA
 //    CENTENA DEZENA UNIDADE
 - não tem escrito a palavra real/reais e nem a palavra centavo/centavos:
    - se for:
        - unidade
            -> Ex: cinco, um, dois, uma, tres
        - ou dezena composta
            -> Ex: doze, quatorze, dezesseis etc
        - ou dezena
            -> Ex: vinte, quarenta, noventa etc
        - ou dezena e unidade
             -> Ex: vinte e cinco , quarenta e nove, setenta e dois etc
        - ou centena
            -> cem, duzentos , setecentos
            -> OBS: aqui não pode ser cento, caso for cento e não tiver mais nada está errado dar erro
        - ou centena e unidade
            -> Ex: cento e um, duzento e nove, quatrocento e sete, quinhentos e dois
        - ou centena e dezena composta
             -> Ex: cento e dezessete, cento e quinze, trezentos e dezenove, quinhentos e dez etc
        - ou centena e dezena
            -> Ex: cento e trinta, cento e noventa, duzentos e cinquenta , novecentos e vinte etc
        - ou centena e dezena e unidade
            -> Ex: cento e noventa e um, cento e trinta e quatro, setecentos e vinte e dois, quatrocentos e sessenta e tres etc
        --> TUDO SERÁ CONVERTIDO REAIS
    
    - toda centena que tiver escrito cem, tudo que vier dps será centavo e o cem será real: tudo deverá virar 100.algumacoisaquevierdps
        - para estar certo tem que vir a palavra cem e dps uma dezena ou dezena composta ou dezena e unidade ou unidade
         -> Exemplo de erro: cem e duzento e vinte cinco
         -> Exemplo de acerto: cem e trinta e cinco = 100.35
         -> Exemplo de acerto: cem e cinco = 100.05

    - agora se for:
         
        
        -> toda parte dps "QUALQUER COISA IGUAL OU ABAIXO DE 99" SERÁ SEMPRE OS CENTAVOS e o antes disso será sempre a parte do real
        
 
    - agora se for:
         //-- CENÁRIO 4 ---------------------------------------
         //    [REAIS]- [CENTAVOS]
         //    DEZENA - DEZENA COMPOSTA
         //    DEZENA - DEZENA
         //    DEZENA - DEZENA E UNIDADE
        - ou dezena e dezena composta
            -> Ex: quarenta e dezoito, trinta e dez, noventa e doze, vinta e dezenove
        - dezena e dezena
            -> Ex: trinta e noventa, cinquenta e trinta, quarenta e cinquenta, vinte e noventa, noventa e trinta
        - ou dezena e dezena e unidade
            -> Ex: sessenta e vinte tres, noventa e noventa e dois, oitenta e vinte um , oienta e oitenta e dois
 
        -> PRIMEIRA DEZENA É REAL a segunda parte é toda CENTAVOS
 
 
    - agora se for:
        - centena e unidade e qualquer coisa igual ou abaixo de 99
            //-- CENÁRIO 6 - CENTENAS UNIDADE ---------------------------------------
            //    [REAIS]          - [CENTAVOS]
            //    CENTENAS UNIDADE - UNIDADE
            //    CENTENAS UNIDADE - DEZENA COMPOSTA
            //    CENTENAS UNIDADE - DEZENA
            //    CENTENAS UNIDADE - DEZENA E UNIDADE
        -> Ex: cento e um e nove, duzentos e cinco e sete, novecentos e tres e tres
        
        - ou centena e dezena e unidade e qualquer coisa igual ou abaixo de 99
            //-- CENÁRIO 6 - CENTENAS DEZENAS UNIDADE ---------------------------------------
            //    [REAIS]                      - [CENTAVOS]
            //    CENTENAS DEZENAS UNIDADE - UNIDADE
            //    CENTENAS DEZENAS UNIDADE - DEZENA COMPOSTA
            //    CENTENAS DEZENAS UNIDADE - DEZENA
            //    CENTENAS DEZENAS UNIDADE - DEZENA E UNIDADE
        -> Ex: cento e trinta e um e dois, trezentos e vinte nove e dezoito, novecentos e quarenta e oito e vinte, etc
 
        - ou centena e dezena composta e qualquer coisa igual ou abaixo de 99
            //-- CENÁRIO 6 - CENTENAS DEZENAS COMPOSTA ---------------------------------------
            //    [REAIS]                   - [CENTAVOS]
            //    CENTENAS DEZENAS COMPOSTA - UNIDADE
            //    CENTENAS DEZENAS COMPOSTA - DEZENA COMPOSTA
            //    CENTENAS DEZENAS COMPOSTA - DEZENA
            //    CENTENAS DEZENAS COMPOSTA - DEZENA E UNIDADE
        -> Ex: duzentos e doze e nove, cento e treze e vinto e dois, duzentos e dezoito e vinte, trezento e dezenove e noventa e cinco
 
         - ou dezena e unidade e qualquer coisa igual ou abaixo de 99
            //-- CENÁRIO 5 ---------------------------------------
            //    [REAIS]          - [CENTAVOS]
            //    DEZENA UNIDADE - UNIDADE
            //    DEZENA UNIDADE - DEZENA COMPOSTA
            //    DEZENA UNIDADE - DEZENA
            //    DEZENA UNIDADE - DEZENA E UNIDADE
         -> Ex: vinte e um e treze, setenta e cinco e noventa e dois, trinta e um e doze

         - ou dezena composta e qualquer coisa igual ou abaixo de 99
            //-- CENÁRIO 3 ---------------------------------------
            //    [REAIS]         - [CENTAVOS]
            //    DEZENA COMPOSTA - UNIDADE
            //    DEZENA COMPOSTA - DEZENA COMPOSTA
            //    DEZENA COMPOSTA - DEZENA
            //    DEZENA COMPOSTA - DEZENA E UNIDADE
         -> Ex: quinze e um, doze e doze, dezesseis e vinte e trez, quinze e noventa e nove, etc
     
         - ou unidade e qualquer coisa igual ou abaixo de 99
            //-- CENÁRIO 2 ---------------------------------------
            //    [REAIS] - [CENTAVOS]
            //    UNIDADE - UNIDADE
            //    UNIDADE - DEZENA COMPOSTA
            //    UNIDADE - DEZENA
            //    UNIDADE - DEZENA E UNIDADE
        -> Ex: oito e noventa e nove, sete e seis, nove e treze etc
 
        -> ATÉ A PRIMEIRA UNIDADE OU PRIMEIRA DEZENA COMPOSTA É REAL, uma regra interessante é sempre que chegar em uma unidade ou dezena composta finaliza a parte real e o que vier dps sempre será centavos.
 
 
    - agora se for:
         //-- CENÁRIO 6 - CENTENAS DEZENAS ---------------------------------------
         //    [REAIS]          - [CENTAVOS]
         //    CENTENAS DEZENAS - DEZENA COMPOSTA
         //    CENTENAS DEZENAS - DEZENA
         //    CENTENAS DEZENAS - DEZENA E UNIDADE
         - ou centena e dezena e dezena composta
             -> Ex: cento e vinte e dezoito, duzentos e trinta e onze
         - centena e dezena e dezena
            -> Ex: cento e vinte e vinte, duzentos e noventa e cinquenta, trezentos e vinte e trinta
         - ou centena e dezena e dezena e unidade
            -> Ex: sessenta e vinte tres, noventa e noventa e dois, oitenta e vinte um , oienta e oitenta e dois
        -> ATÉ A PRIMEIRA DEZENA É REAL a segunda parte é toda centavo
        

 
 1 - separar todos os textos por " "
 
 2 - analisar os textos
    2.1 - se tiver o texto "e": remover
 
 3 - identificar se tem os textos: "real" ou "reais"
 
 4 - identificar se tem os textos: "centavo" ou "centavos"
 
 5 - Analisar os passos 3 e 4
 
 6 - Tem ambas palavras: ("real" ou "reais") e ("centavo" ou "centavos")
    - 6.1 - remover o texto encontrado no item 4
    - 6.2 - pegar todos os numeros antes da palavra identificada no passo 3
        - 6.2.1 - somar todas e armazenar como a parte real
 
    - 6.3 - pegar todos os numeros dps da palavra identificada no passo 3
        - 6.3.1 - somar todos e armazenar como parte centavo
        - 6.3.2 - se a soma ultrapassar 99 gerar erro!
 
 
 7 - Só tem a palavra encontrada no item 3: ("real" ou "reais")
    - 7.1 - ir para o passo 6.2
 
 
 8 - Só tem a palavra encontrada no item 4: ("centavo" ou "centavos")
    - 8.1 - percorrer todos os textos o indice 0 até last indice
    
    - 8.2 - identificou uma UNIDADE ou DEZENA COMPOSTA:
        - 8.2.1 - Tem próximo indice?
            - 8.2.1.1 - Sim, reiniciar a leitura e seguir para o passo 9.1
            - 8.2.1.2 - Não, somar todos e armazenar como parte centavo
            - fim

    - 8.3 - identificou uma DEZENA:
        - 8.3.1 - verificar o próximo indice
        
        - 8.3.2 - Não tem próximo indice
            - 8.3.2.1 - somar tudo e armazenar como centavo
            - fim

         - 8.3.3 - é uma UNIDADE:
            - 8.3.3.1 - seguir para o passo 8.2

         - 8.3.4 - é uma DEZENA:
            - 8.3.4.1 - seguir para o passo 9.1
    
    - 8.4 - identificou uma CENTENA:
        - 8.4.1 - seguir para o passo 9.1
 

 9 - Não foi identificado nenhuma das palavras do passos 3 e 4: ("real" ou "reais") e ("centavo" ou "centavos")
    - 9.1 - percorrer todos os textos o indice "0"(ZERO) até last indice
 
    - 9.2 - identificou uma UNIDADE ou DEZENA COMPOSTA:
        - 9.2.1 - somar todos os numeros antes da unidade incluindo a unidade e armazenar como parte real
        - 9.2.2 - somar todos os numeros dps da unidade e armazenar como parte centavo
            - 9.2.2.1 - se não tiver nada dps da unidade signfica q não tem centavos e tudo era real
 
     
    - 9.3 - identificou uma DEZENA:
        - 9.3.1 - verificar o próximo indice
 
        - 9.3.2 - Não tem próximo indice
            - 9.3.2.1 - somar tudo e armazenar como real
 
        - 9.3.3 - é uma UNIDADE:
            - 9.3.3.1 - seguir para o passo 9.2 e finalizar
 
        - 9.3.4 - é uma DEZENA ou DEZENA COMPOSTA:
            - 9.3.4.1 - somar tudo antes da dezena ou composta encontrada, não incluí-los, e armazenar como Real
            - 9.3.4.2 - somar tudo dps da dezena ou dezena composta encontrada, incluindo a dezena, e armazenar como parte centavo
                - 9.3.4.2.1 - se a soma ultrapassar 99, gerar erro !!!!
 
 
    - 9.4 - identificou uma CENTENA:
        - 9.4.1 - retorna para o passo 9.1 e segue para o próximo indice.
    
 
 
 
 
 static let UNIDADE: [String: Int] = [
     "zero": 0, "um": 1, "uma": 1, "dois": 2, "duas": 2, "três": 3, "tres": 3, "quatro": 4,
     "cinco": 5, "seis": 6, "sete": 7, "oito": 8, "nove": 9
 ]

 static let DEZENA COMPOSTA: [String: Int] = [
     "dez": 10, "onze": 11, "doze": 12, "treze": 13, "quatorze": 14, "catorze": 14,
     "quinze": 15, "dezesseis": 16, "dezessete": 17, "dezoito": 18, "dezenove": 19
 ]

 static let DEZENA: [String: Int] = [
     "vinte": 20, "trinta": 30, "quarenta": 40, "cinquenta": 50, "sessenta": 60,
     "setenta": 70, "oitenta": 80, "noventa": 90
 ]

 static let CENTENA: [String: Int] = [
     "cem": 100, "cento": 100, "duzentos": 200, "trezentos": 300,
     "quatrocentos": 400, "quinhentos": 500, "seiscentos": 600,
     "setecentos": 700, "oitocentos": 800, "novecentos": 900
 ]
 
*/



import Foundation

enum TextToDecimalParserError: Error, CustomStringConvertible {
    case invalidCentavosSum
    case invalidFormat

    var description: String {
        switch self {
        case .invalidCentavosSum:
            return "A soma dos centavos ultrapassa 99."
        case .invalidFormat:
            return "Formato de entrada inválido."
        }
    }
}

class TextoParaValorParser {
    static let UNIDADE: [String: Int] = [
        "zero": 0, "um": 1, "uma": 1, "dois": 2, "duas": 2, "três": 3, "tres": 3,
        "quatro": 4, "cinco": 5, "seis": 6, "sete": 7, "oito": 8, "nove": 9
    ]

    static let DEZENA_COMPOSTA: [String: Int] = [
        "dez": 10, "onze": 11, "doze": 12, "treze": 13, "quatorze": 14, "catorze": 14,
        "quinze": 15, "dezesseis": 16, "dezessete": 17, "dezoito": 18, "dezenove": 19
    ]
    
    static let DEZENA: [String: Int] = [
        "vinte": 20, "trinta": 30, "quarenta": 40, "cinquenta": 50,
        "sessenta": 60, "setenta": 70, "oitenta": 80, "noventa": 90
    ]
    
    static let CENTENA: [String: Int] = [
        "cem": 100, "cento": 100, "duzentos": 200, "trezentos": 300,
        "quatrocentos": 400, "quinhentos": 500, "seiscentos": 600,
        "setecentos": 700, "oitocentos": 800, "novecentos": 900
    ]
    
    static func parse(_ text: String) throws -> Decimal {
        var words = text.lowercased().components(separatedBy: " ")
        words.removeAll { $0 == "e" }
        
        let hasReais = words.contains(where: { $0 == "real" || $0 == "reais" })
        let hasCents = words.contains(where: { $0 == "centavo" || $0 == "centavos" })
        
        var reais = 0
        var centavos = 0
        
        if hasReais {
            return try cenarioTemPalavraReais(words)
        }
        
        if !hasReais && hasCents {
            return cenarioSoTemCentavo(words)
        }
        
        if !hasReais && !hasCents {
            return fluxo91(words)
        }
        
        return .zero
    }
    
    private static func hasNextIndex(_ index: Int , _ words: [String]) -> Bool { index < words.count - 1 }
    
    private static func cenarioSoTemCentavo(_ words: [String]) -> Decimal {
        var flag9_1 = false
        var words = words
        
        words.removeAll { $0 == "centavo" || $0 == "centavos" }
        
        var numbers = [Int]()
        
        for (index, word) in words.enumerated().reversed() {
            print(index)
            
            let number = converterTextToNumber(word)
            
            numbers.append(number.value)
            
            if number.type == .unit {
                if index == 0 {
                    return (Decimal(string: "\(number.value)") ?? 0) / 100
                }
                
                let beforeNumber = converterTextToNumber(words[index-1])
                
                numbers.append(beforeNumber.value)
                
                if beforeNumber.type != .ten {
                    return sumRealAndCents(index-1, words)
                }
                
                return sumRealAndCents(index-2, words)
            }
            
            if number.type == .compoundTen {
                return sumRealAndCents(index-1, words)
            }
            
            if number.type == .ten {
                if index == 0 {
                    return (Decimal(string: "\(number.value)") ?? 0) / 100
                }
                
                return sumRealAndCents(index-1, words)
            }
               
        }
        
        return .zero
    }
    
    
    private static func cenarioTemPalavraReais(_ text: [String]) throws -> Decimal {
        var text = text
        
        text.removeAll { $0 == "centavo" || $0 == "centavos" }
        
        guard let indexReal = text.firstIndex(where: { $0 == "real" || $0 == "reais" }) else {
            throw TextToDecimalParserError.invalidFormat
        }
        
        text.removeAll { $0 == "real" || $0 == "real" }
        
        return sumRealAndCents(indexReal - 1, text)
    }
    
    private enum NumberPartType {
        case none
        case unit
        case compoundTen
        case ten
        case hundred
    }
    
    private static func converterTextToNumber(_ text: String) -> (type: NumberPartType, value: Int) {
        let text = text.lowercased()
        
        if let number = UNIDADE[text]  { return (.unit, number) }
        
        if let number = DEZENA_COMPOSTA[text] { return (.compoundTen, number) }
        
        if let number = DEZENA[text] { return (.ten, number) }
        
        if let number = CENTENA[text] { return (.hundred, number) }
        
        return (.none, 0)
    }
    
    private static func sumRealAndCents(_ indexReal: Int , _ text: [String]) -> Decimal {
        let realWords = Array(text[0..<indexReal+1])
        
        let centavoWords = Array( text[(indexReal+1)..<text.endIndex])
        
        let sumReal = realWords.reduce(0) { partialResult, text in
            let number = converterTextToNumber(text)
            return partialResult + number.value
        }
        
        let sumCents = centavoWords.reduce(0) { partialResult, text in
            let number = converterTextToNumber(text)
            return partialResult + number.value
        }
                
        return (Decimal(string: "\(sumReal)\(String(format: "%02d", sumCents))") ?? 0) / 100
    }
    
    private static func fluxo91(_ words: [String]) -> Decimal {
        var numbers = [Int]()
                
        for (index, text) in words.enumerated() {
            
            let number = converterTextToNumber(text)
            
            numbers.append(number.value)
            
            if number.type == .unit || number.type == .compoundTen {
                return sumRealAndCents(index, words)
            }
            
            
            if number.type == .ten {
                if !hasNextIndex(index, words) {
                    let total = numbers.reduce(0, +)
                    return (Decimal(string: "\(total)") ?? 0)
                }
                
                let nextNumber = converterTextToNumber(words[index + 1])
                
                if nextNumber.type == .ten || nextNumber.type == .compoundTen {
                    return sumRealAndCents(index, words)
                }
            }
            
            if number.type == .hundred {
                if text == "cem" {
                    return sumRealAndCents(index, words)
                }
                
                if !hasNextIndex(index, words) {
                    let total = numbers.reduce(0, +)
                    return (Decimal(string: "\(total)") ?? 0)
                }
            }
            
        }
        
        return 0
    }
    
}

