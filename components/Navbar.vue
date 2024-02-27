<template>
    
    <div class="bg-white w-full flex justify-center">
        
        <div class="w-1/2 border-black border-2 rounded-md mt-4">
            <div class="w-full flex justify-between bg-white">
                <h2 class="text-black pl-4 my-2 font-bold text-4xl">E.P. Chan & Associates</h2>
                <h3 class="text-slate-400 pr-4 my-2 text-2xl truncate"><i>Quantitative Trading</i></h3>
            </div>
            <div class="w-auto">
                <img src="/img/banner.jpg">
            </div>
            <nav class="p-5 bg-white shadow 2xl:flex 2xl:items-center 2xl:justify-center w-auto">
                <div class="flex justify-between items-center ">
                    <!-- <span class="font-bold text-2xl font-[Arial] cursor-pointer hover:text-orange-500 duration-500 truncate">
                        
                        <NuxtLink to="/">E.P. Chan & Associates</NuxtLink>
                    </span> -->

                    <span class="text-3xl cursor-pointer 2xl:hidden block mx-2 mb-2">
                        
                        <Icon class="hover:text-orange-500 duration-500" name="mingcute:align-justify-fill"></Icon>
                    </span>
                </div>

                    <ul class="2xl:flex 2xl:items-center z-[-1] 2xl:z-auto 2xl:static absolute bg-white w-full left-0 2xl:w-auto 2xl:py-0 py-4 2xl:pl-0 pl-7
                                2xl:opacity-100 opacity-0 top-[-400px] transition-all ease-in duration-500 ">
                        <li class="mx-1 my-6 2xl:my-0">
                            <NuxtLink to="/" class="text-sm font-bold hover:text-orange-500 duration-500 cursor-pointer">Home</NuxtLink>
                        </li>
                        <li class="mx-4 my-6 2xl:my-0 truncate">
                            <NuxtLink to="/financial-machine-learning" class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Financial
                                Machine Learning</NuxtLink>
                        </li>
                        <li class="mx-4 my-6 2xl:my-0">
                            <NuxtLink to='/workshops' class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Workshops</NuxtLink>
                        </li>
                        <li class="mx-4 my-6 2xl:my-0">
                            <NuxtLink to='/books' class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Books</NuxtLink>
                        </li>
                        <li class="mx-4 my-6 2xl:my-0 truncate">
                            <NuxtLink to="/investment-management" class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Investment Management
                            </NuxtLink>
                        </li>
                        <li class="mx-4 my-6 2xl:my-0">
                            <NuxtLink to="/about" class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">
                                About Us</NuxtLink>
                        </li>
                        <li class="mx-1 my-6 2xl:my-0">
                        <NuxtLink to="/email" class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Email</NuxtLink>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</template>

<script setup>

</script>

<style lang="scss" scoped>

</style>