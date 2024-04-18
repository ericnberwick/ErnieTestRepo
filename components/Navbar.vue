<template>

    <div class="bg-white w-full flex justify-center">

        <div class="w-7/12 border-black border-2 rounded-md mt-4">
            <div class="w-full flex justify-between bg-white">
                <h2 class="text-black pl-4 my-2 font-bold text-4xl">E.P. Chan & Associates</h2>
                <h3 class="text-slate-400 pr-4 my-2 text-2xl truncate"><i>Quantitative Trading</i></h3>
            </div>
            <div class="w-full flex justify-center">
                
                <NuxtImg src="/img/banner.jpg"></NuxtImg>
            </div>
            <nav class="p-5 bg-white shadow 2xl:flex 2xl:items-center 2xl:justify-center w-auto">
                <div class="flex justify-between items-center ">
                    <!-- <span class="font-bold text-2xl font-[Arial] cursor-pointer hover:text-orange-500 duration-500 truncate">
                        
                        <NuxtLink to="/">E.P. Chan & Associates</NuxtLink>
                    </span> -->

                    <span class="text-3xl cursor-pointer 2xl:hidden block mx-2 mb-2 w-full ">
                        <div class="w-full flex justify-end">
                            <Icon class="hover:text-orange-500 duration-500 " name="mingcute:align-justify-fill" @click="toggleNavbarUI" v-show="!showNavbarUI"></Icon>
                            <Icon class="hover:text-orange-500 duration-500 " name="maki:cross" @click="toggleNavbarUI" v-show="showNavbarUI"></Icon>
                        </div>
                        
                        <div style="background-color: #EE8222;" class="text-white w-full"  name="mingcute:align-justify-fill"
                            v-if="showNavbarUI">
                            <ul class="flex flex-col items-center">
                                
                                <li class=" truncate hover:bg-orange-400 duration-500 cursor-pointer w-full text-center pb-3">
                                    <NuxtLink to="/"
                                        class="text-base font-semibold">Home
                                    </NuxtLink>
                                </li>
                            
                                <li class=" truncate hover:bg-orange-400 duration-500 cursor-pointer w-full text-center pb-3">
                                    <NuxtLink to="/financial-machine-learning"
                                        class="text-base font-semibold  duration-500 cursor-pointer ">
                                        Financial
                                        Machine Learning</NuxtLink>
                                </li>
                                <li class=" hover:bg-orange-400 duration-500 cursor-pointer w-full text-center pb-3">
                                    <NuxtLink to='/workshops'
                                        class="text-base font-semibold  duration-500 cursor-pointer  ">
                                        Workshops</NuxtLink>
                                </li>
                                <li class=" hover:bg-orange-400 duration-500 cursor-pointer w-full text-center pb-3">
                                    <NuxtLink to='/books'
                                        class="text-base font-semibold  duration-500 cursor-pointer ">
                                        Books</NuxtLink>
                                </li>
                                <li class=" truncate hover:bg-orange-400 duration-500 cursor-pointer w-full text-center pb-3">
                                    <NuxtLink to="/investment-management"
                                        class="text-base font-semibold  duration-500 cursor-pointer ">
                                        Investment Management
                                    </NuxtLink>
                                </li>
                                <li class=" hover:bg-orange-400 duration-500 cursor-pointer w-full text-center pb-3">
                                    <NuxtLink to="/about"
                                        class="text-base font-semibold  duration-500 cursor-pointer ">
                                        About Us</NuxtLink>
                                </li>
                                <li class=" hover:bg-orange-400 duration-500 cursor-pointer w-full text-center pb-3">
                                    <NuxtLink to="/email"
                                        class="text-base font-semibold  duration-500 cursor-pointer ">
                                        E-mail</NuxtLink>
                                </li>
                            </ul>
                        </div>
                    </span>

                </div>

                <ul class="2xl:flex 2xl:items-center z-[-1] 2xl:z-auto 2xl:static absolute bg-white w-full left-0 2xl:w-auto 2xl:py-0 py-4 2xl:pl-0 pl-7
                                2xl:opacity-100 opacity-0 top-[-400px] transition-all ease-in duration-500 ">
                    <li class="mx-1 my-6 2xl:my-0">
                        <NuxtLink to="/" class="text-sm font-bold hover:text-orange-500 duration-500 cursor-pointer">
                            Home</NuxtLink>
                    </li>
                    <li class="mx-4 my-6 2xl:my-0 truncate">
                        <NuxtLink to="/financial-machine-learning"
                            class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Financial
                            Machine Learning</NuxtLink>
                    </li>
                    <li class="mx-4 my-6 2xl:my-0">
                        <NuxtLink to='/workshops'
                            class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Workshops
                        </NuxtLink>
                    </li>
                    <li class="mx-4 my-6 2xl:my-0">
                        <NuxtLink to='/books'
                            class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Books</NuxtLink>
                    </li>
                    <li class="mx-4 my-6 2xl:my-0 truncate">
                        <NuxtLink to="/investment-management"
                            class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Investment
                            Management
                        </NuxtLink>
                    </li>
                    <li class="mx-4 my-6 2xl:my-0">
                        <NuxtLink to="/about"
                            class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">
                            About Us</NuxtLink>
                    </li>
                    <li class="mx-1 my-6 2xl:my-0">
                        <NuxtLink to="/email"
                            class="text-sm hover:text-orange-500 duration-500 cursor-pointer font-bold">Email</NuxtLink>
                    </li>
                </ul>

            </nav>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';

var showNavbarUI = ref(false);

function toggleNavbarUI() {
  showNavbarUI.value = !showNavbarUI.value;
  console.log("show nav bar ", showNavbarUI)
  
}


</script>

<style lang="scss" scoped>

</style>