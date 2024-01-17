add_rules("mode.debug", "mode.release")

add_requires("openmp", "corrade", "eigen")
local magnumconfs = {sdl2 = true}
add_requires("magnum", {configs = magnumconfs})
add_requires("magnum-integration", {configs = {imgui = true, eigen = true}})
add_requireconfs("magnum-integration.magnum", {configs = magnumconfs})
add_requireconfs("magnum-integration.imgui", {version = "1.76", override = true})

set_languages("c++20")

add_rules("@corrade/resource")

target("WaveGrid")
    set_kind("static")
    add_packages("openmp", "eigen", {public = true})
    add_includedirs("src", {public = true})
    if is_plat("windows") then add_cxflags("/bigobj") end
    add_files("src/WaveGrid.cpp", "src/Enviroment.cpp", "src/Grid.cpp", "src/ProfileBuffer.cpp", "src/Spectrum.cpp")

target("Demo")
    set_kind("binary")
    add_deps("WaveGrid")
    add_files("src/visualization/Demo.cpp",
              "src/visualization/base/SceneBase3D.cpp",
              "src/visualization/drawables/Primitives3D.cpp",
              "src/visualization/waterSurface/WaterSurfaceShader.cpp",
              "src/visualization/waterSurface/WaterSurfaceMesh.cpp")
    add_files("src/visualization/waterSurface/resources.conf")
    add_packages("openmp", "corrade", "magnum", "magnum-integration")
