{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    const container = document.getElementsByClassName('container')
    if (container.length > 0) {
      container[0].remove();
    }
    await appRunner.runApp();
  } 
})