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

steps_patent = [
    {
        title: "Datos Generales del o de los solicitantes",
        order: 0,
        template: 'general_data_applicants_industrial_property',
        disabled: false
    },
    {
        title: "Datos del o de los inventores",
        order: 1,
        template: 'data_inventors_industrial_property',
        disabled: true
    },
    {
        title: "Datos del o de los apoderados",
        order: 2,
        template: 'data_owner_industrial_property',
        disabled: true
    },
    {
        title: "Datos de la propiedad industrial",
        order: 3,
        template: 'data_patent_industrial_property',
        disabled: true
    }
]
patent = ApplicationType.create(id: ApplicationType::PATENT, name: "Registro de Patente, Registro de Modelo de Utilidad y Registro de Diseño Industrial.", steps: steps_patent.to_json)

copyright = ApplicationType.create(id: ApplicationType::COPYRIGHT, name: "Registro de derechos de autor")