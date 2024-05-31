<template>
    <div>
        <Navbar page="email"></Navbar>
        <div class="flex justify-center">
            <div class="w-10/12 ">
                <header class="flex justify-content ">
                    <h1>E-mail</h1>
                </header>
                <hr >

                <div class="flex justify-content ">
                    
                    <a>ernest@epchan.com</a>
                </div>
            </div>
        </div>    

    </div>
</template>

<script setup>

</script>

<style lang="scss" scoped>
.line{
    color: #444444;
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
a {
    color: #444444; /* Initial Color */
    transition: color 0.2s ease-in-out, font-size 0.2s ease-in-out; /* Smooth transition for color and font-size */
}

a:hover {
    color: #0056b3; /* Darker shade of blue on hover */
    
}
</style>