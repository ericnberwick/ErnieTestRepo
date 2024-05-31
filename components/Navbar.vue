<template>
    
    <div class="bg-white w-full flex justify-center ">

        <div class="w-11/12 border-black border-2 rounded-xl mt-4 px-3">
            <div class="w-full flex items-center justify-between bg-white px-6 py-3">
                <NuxtLink to="/"><h2 class="font-bold text-5xl text-grey-700">E.P. Chan & Associates</h2></NuxtLink>
                <h3 class="text-2xl text-gray-600 italics pr-4">Quantitative Trading</h3>
                
            </div>
            <div class="w-full flex justify-center">

                <NuxtImg src="/img/banner.jpg"></NuxtImg>
            </div>
            <nav class="p-5 bg-white shadow md:flex md:items-center md:justify-center w-auto">
                <div class="flex justify-between items-center ">

                    <span class="text-3xl cursor-pointer md:hidden block mx-2 mb-2 w-full ">
                        <div class="w-full flex justify-end">
                            <Icon class="hover:text-orange-500 duration-500 " name="mingcute:align-justify-fill"
                                @click="toggleNavbarUI" v-show="!showNavbarUI"></Icon>
                            <Icon class="hover:text-orange-500 duration-500 " name="maki:cross" @click="toggleNavbarUI"
                                v-show="showNavbarUI"></Icon>
                        </div>

                        <div style="background-color: #EE8222;" class="text-white w-full"
                            name="mingcute:align-justify-fill" v-if="showNavbarUI">
                            <div class="flex flex-col items-center">

                                <NuxtLink to="/"
                                    class=" truncate hover:bg-orange-400 duration-500 cursor-pointer w-full text-center p-3 text-base font-semibold">
                                    Home
                                </NuxtLink>

                                <NuxtLink to="/financial-machine-learning"
                                    class="truncate hover:bg-orange-400 duration-500 cursor-pointer w-full text-center p-3 text-base font-semibold  duration-500 cursor-pointer ">
                                    Financial
                                    Machine Learning</NuxtLink>

                                <NuxtLink to='/workshops'
                                    class="hover:bg-orange-400 duration-500 cursor-pointer w-full text-center p-3 text-base font-semibold  duration-500 cursor-pointer  ">
                                    Workshops</NuxtLink>

                                <NuxtLink to='/books'
                                    class="hover:bg-orange-400 duration-500 cursor-pointer w-full text-center p-3 text-base font-semibold  duration-500 cursor-pointer ">
                                    Books</NuxtLink>

                                <NuxtLink to="/investment-management"
                                    class="truncate hover:bg-orange-400 duration-500 cursor-pointer w-full text-center p-3 text-base font-semibold  duration-500 cursor-pointer ">
                                    Investment Management
                                </NuxtLink>

                                <NuxtLink to="/about"
                                    class="hover:bg-orange-400 duration-500 cursor-pointer w-full text-center p-3 text-base font-semibold  duration-500 cursor-pointer ">
                                    About Us</NuxtLink>

                                <NuxtLink to="/email"
                                    class="hover:bg-orange-400 duration-500 cursor-pointer w-full text-center p-3 text-base font-semibold  duration-500 cursor-pointer ">
                                    E-mail</NuxtLink>

                            </div>
                        </div>
                    </span>

                </div>

                <ul class="md:flex md:items-center z-[-1] md:z-auto md:static absolute bg-white w-full left-0 md:w-auto md:py-0 py-4 md:pl-0 pl-7
                                md:opacity-100 opacity-0 top-[-400px] transition-all ease-in duration-500 ">
                    <li class="mx-1 my-6 md:my-0" :class="{ 'text-orange-500': props.page === 'home' }">
                        <NuxtLink to="/" class="text-base font-bold hover:text-orange-500 duration-500 cursor-pointer">
                            Home</NuxtLink>
                    </li>
                    <li class="mx-2 my-6 md:my-0 truncate" :class="{ 'text-orange-500': props.page === 'financial' }">
                        <NuxtLink to="/financial-machine-learning"
                            class="text-base hover:text-orange-500 duration-500 cursor-pointer font-bold">Financial
                            Machine Learning</NuxtLink>
                    </li>
                    <li class="mx-2 my-6 md:my-0" :class="{ 'text-orange-500': props.page === 'workshop' }">
                        <NuxtLink to='/workshops'
                            class="text-base hover:text-orange-500 duration-500 cursor-pointer font-bold">Workshops
                        </NuxtLink>
                    </li>
                    <li class="mx-2 my-6 md:my-0" :class="{ 'text-orange-500': props.page === 'books' }">
                        <NuxtLink to='/books'
                            class="text-base hover:text-orange-500 duration-500 cursor-pointer font-bold">Books
                        </NuxtLink>
                    </li>
                    <li class="mx-2 my-6 md:my-0 truncate" :class="{ 'text-orange-500': props.page === 'invest' }">
                        <NuxtLink to="/investment-management"
                            class="text-base hover:text-orange-500 duration-500 cursor-pointer font-bold">Investment
                            Management
                        </NuxtLink>
                    </li>
                    <li class="mx-2 my-6 md:my-0" :class="{ 'text-orange-500': props.page === 'about' }">
                        <NuxtLink to="/about"
                            class="text-base hover:text-orange-500 duration-500 cursor-pointer font-bold">
                            About Us</NuxtLink>
                    </li>
                    <li class="mx-1 my-6 md:my-0" :class="{ 'text-orange-500': props.page === 'email' }">
                        <NuxtLink to="/email"
                            class="text-base hover:text-orange-500 duration-500 cursor-pointer font-bold">E-mail
                        </NuxtLink>
                    </li>
                </ul>

            </nav>
        </div>
    </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';




const props = defineProps({
  page: {
    type: String,
    required: true
  }
});

watch(() => props.page, (newVal, oldVal) => {
}, { immediate: true });

let showNavbarUI = ref(false);

const toggleNavbarUI = () => {
  showNavbarUI.value = !showNavbarUI.value;
}

</script>

<style lang="scss" scoped>



</style>