#Definição das funções para cálculo de massa
class Mass 
    def initialize
        @a1 = 0.01691
        @a2 = 0.01911
        @a3 = 0.000763
        @a4 = 0.10175
        @a5 = 0.012
    end

    #Cálculo do número de neutrons
    def setN (z, a)
        @n = z - a 
    end

    #Definição da função principal
    def dropModel (z, a)
        value = f0(z, a) + f1(z, a) + f2(z, a) + f3(z, a) + f4(z, a) + f5(z, a)
        return value
    end

    #Cálculo da massa das partes dos constituintes do átomo
    def f0 (z, a)
        f0 = (1.0078 * z) + (1.0087 * (a - z))
        return f0
    end

    #Termo de Volume
    def f1 (z, a)
        f1 = - @a1 * a
        return f1
    end

    #Termo de Superfície
    def f2 (z, a)
        f2 =  @a2 * Math.cbrt(a**2)
        return f2
    end

    #Termo Coulombiano
    def f3 (z, a)
        f3 = (@a3 * z**2) / Math.cbrt(a)
        return f3
    end

    #Termo de Assimetria
    def f4 (z, a)
        f4 = @a4 * ((z- a/2)**2) / a
        return f4 
    end

    #Termo de Emparelhamento
    def f5 (z, a)
        if z % 2 == 0 && @n % 2 == 0
            f5 = - @a5 / Math.sqrt(a) 
        elsif z % 2 == 0 && @n % 2 != 0
            f5 = 0
        elsif z % 2 != 0 && @n % 2 == 0
            f5 = 0 
        elsif z % 2 != 0 && @n % 2 != 0
            f5 = - @a5 / Math.sqrt(a)
        end
        return f5
    end

    #Definição de função para cálculo da energia de ligação
    def bindingEnergy (z, a)
        return (f0(z, a) - dropModel(z, a)) * 931.48 
    end

    #Definição de função para cálculo da energia de ligação por nucleon
    def nucleonEnergy (z, a)
        return (f0(z, a) - dropModel(z, a)) / (a * 931.5) 
        
    end
end 

#Modelo nuclear da Gota Líquida

var = Mass.new()

loop do
    puts "\t\t Modelo Nuclear da Gota Líquida" 
    print "\nDigite o número atômico do átomo (Z): "
    z = gets.chomp.to_f
    print 'Digite o número de massa do átomo (A): '
    a = gets.chomp.to_f

    var.setN(z, a)

    puts "\n Escolha uma opção: "
    puts '1 - Cálculo de massa.'
    puts '2 - Cálculo da Energia de Ligação.'
    puts '3 - Cálculo da Energia de Ligação por Nucleon'
    puts '0 - Sair'

    option = gets.chomp.to_i

    case option
        when 1
            puts 'A massa desse átomo é:'
            puts var.dropModel(z, a)
            system "clear"

        when 2
            puts 'A energia de ligação desse átomo é:'
            puts var.bindingEnergy(z, a)
            system "clear"
            
        when 3
            puts 'A energia de ligação por nucleon desse átomo é:'
            puts var.nucleonEnergy(z, a)
            system "clear"

        when 0
            puts 'Até Logo!'
            system "clear"
            break

        else
            puts 'Valor Inválido' 
            system "clear"
            
        end
end  
     


