<template>
    <!-- border-sky-400 border-2  -->
    <div>
        <Navbar page="home"></Navbar>

        <div class="mx-8 mt-2">
            
            
            <div class="flex justify-center">
                <div class=" w-7/12">
                    <header class="flex justify-content ">
                        <h1>Home</h1>
                
                    </header>
                    <hr>
                    
                    <p class="text-lg font-arial"> 
                        Dr. Ernest P. Chan, is an expert in the application of statistical models and software for trading currencies,
                         futures, and stocks. He manages a hedge fund and SMAs at <a href="https://qtscm.com/" class="underline">QTS Capital Management, LLC</a>. and a financial machine 
                         learning SaaS <a class="underline" href="https://predictnow.ai/">Predictnow.ai</a>. Dr. Chan has built and traded numerous quantitative models for investment banks 
                         and hedge funds in the past. He has served individual and institutional clients in Australia, Canada, China,
                          France, India, Israel, Italy, Russia, Singapore, South Africa, the United Kingdom, and the United States since 2006.
                    </p>
                    
                    

                    <div class="mt-20">
                        <hr class="border-black border-2">
                    
                            <p><Icon name="ic:round-copyright"> </Icon> 2022 . E.P. Chan & Associates</p>
                        
                    </div>    
                </div>
                
            </div>
            
        </div>
    </div>
</template>

<script setup>
</script>

<style scoped>
a {
    color: #444444; /* Initial Color */
    transition: color 0.2s ease-in-out, font-size 0.2s ease-in-out; /* Smooth transition for color and font-size */
}

a:hover {
    color: #0056b3; /* Darker shade of blue on hover */
    
}
h1{
    margin-top: 10px;
    margin-bottom: 7px;
    font-size: 20px;
    color: #445566;
    font-weight: bold;
}

h2{
    margin-bottom: 20px;
    font-size: 20px;
    color: #445566;
    font-weight: 400;
}
p{
    font-family: 'Arial', sans-serif;
    margin: 20px 0;
    font-size: 15px;
    color: #444444;
}

body {
  font-family: 'Arial', sans-serif;
}

</style>