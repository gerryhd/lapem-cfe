steps_brand = [
    {
        title: "Datos Generales del o de los solicitantes",
        order: 0,
        template: 'general_data_applicants',
        disabled: false
    },
    {
        title: "Domicilio del solicitante",
        order: 1,
        template: 'address_applicants',
        disabled: true
    },
    {
        title: "Domicilio para oír y recibir notificaiciones",
        order: 2,
        template: 'address_notification',
        disabled: true
    },
    {
        title: "Datos del signo distintivo",
        order: 3,
        template: 'data_sign_type',
        disabled: true
    }
]
brand = ApplicationType.create(id: ApplicationType::BRAND, name: "Registro Marcas, Avisos y Nombres Comerciales", steps: steps_brand.to_json)

patent = ApplicationType.create(id: ApplicationType::PATENT, name: "Registro de Patente, Registro de Modelo de Utilidad y Registro de Diseño Industrial.")
copyright = ApplicationType.create(id: ApplicationType::COPYRIGHT, name: "Registro de derechos de autor")