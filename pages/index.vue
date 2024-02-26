<template>
    <div class="bg-gray-800 w-full h-screen flex gap-16 flex-col">
        <nav class="bg-firefly-dark ">
            <Navbar />
        </nav>
        <div class="flex justify-center items-center w-full pt-32 text-3xl gradient-text text-center">
            <span class="w-1/2">
                Unlock the Full Potential of Quantitative Trading with Our Comprehensive
                Online Workshop
            </span>
        </div>
        <div class="flex justify-center">
            <NuxtLink to="/workshops-store"
                class="mx-auto bg-firefly-accent text-firefly-dark py-2 px-4 rounded hover:bg-opacity-75">Start Learning
                Today</NuxtLink>
        </div>
    </div>
</template>

<script setup>
</script>

<style scoped>
.gradient-text {
    background-image: linear-gradient(85deg,
            hsl(240deg 100% 74%) 0%,
            hsl(275deg 100% 69%) 10%,
            hsl(310deg 100% 65%) 20%,
            hsl(345deg 100% 60%) 30%,
            hsl(20deg 100% 55%) 40%,
            hsl(55deg 100% 50%) 50%,
            hsl(73deg 90% 53%) 60%,
            hsl(91deg 79% 56%) 70%,
            hsl(109deg 70% 60%) 80%,
            hsl(127deg 59% 63%) 90%,
            hsl(145deg 49% 66%) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
</style>
