_flutter.loader.load({
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}},
  },
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine({
      renderer: "html",
      canvasKitBaseUrl: "", // يمنع تحميل CanvasKit
    });
    await appRunner.runApp();
  }
});
