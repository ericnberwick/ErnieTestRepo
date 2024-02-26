<template>
    <nav class="p-5 bg-white shadow md:flex md:items-center md:justify-between">
        <div class="flex justify-between items-center ">
            <span class="font-bold text-2xl font-[Arial] cursor-pointer hover:text-orange-500 duration-500 truncate">
                <img class="h-10 inline px-4" src="/img/predict.jpg">
                <NuxtLink to="/">E.P. Chan & Associates</NuxtLink>
            </span>

            <span class="text-3xl cursor-pointer md:hidden block mx-2 mb-2">
                
                <Icon class="hover:text-orange-500 duration-500" name="mingcute:align-justify-fill"></Icon>
            </span>
        </div>

        <ul class="md:flex md:items-center z-[-1] md:z-auto md:static absolute bg-white w-full left-0 md:w-auto md:py-0 py-4 md:pl-0 pl-7
                    md:opacity-100 opacity-0 top-[-400px] transition-all ease-in duration-500 ">
            <li class="mx-4 my-6 md:my-0">
                <NuxtLink to="/" class="text-xl font-bold hover:text-orange-500 duration-500 cursor-pointer">Home</NuxtLink>
            </li>
            <li class="mx-4 my-6 md:my-0 truncate">
                <NuxtLink to="/about" class="text-xl hover:text-orange-500 duration-500 cursor-pointer font-bold">Financial
                    Machine Learning</NuxtLink>
            </li>
            <li class="mx-4 my-6 md:my-0">
                <NuxtLink class="text-xl hover:text-orange-500 duration-500 cursor-pointer font-bold">Workshops</NuxtLink>
            </li>
            <li class="mx-4 my-6 md:my-0">
                <NuxtLink class="text-xl hover:text-orange-500 duration-500 cursor-pointer font-bold">Books</NuxtLink>
            </li>
            <li class="mx-4 my-6 md:my-0 truncate">
                <NuxtLink class="text-xl hover:text-orange-500 duration-500 cursor-pointer font-bold">Investment Management
                </NuxtLink>
            </li>
            <li class="mx-4 my-6 md:my-0">
                <NuxtLink to="/workshops-store" class="text-xl hover:text-orange-500 duration-500 cursor-pointer font-bold">
                    About Us</NuxtLink>
            </li>
            <li class="mx-4 my-6 md:my-0">
            <NuxtLink class="text-xl hover:text-orange-500 duration-500 cursor-pointer font-bold">Email</NuxtLink>
        </li>
    </ul>
</nav></template>

<script setup>

</script>

<style lang="scss" scoped>

</style>