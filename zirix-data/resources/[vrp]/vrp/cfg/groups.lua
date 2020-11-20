local cfg = {}

cfg.groups = {
	--[	Departamento Executivo ]-------------------------------------------------

	['prefeitura'] = {
		_config = {
			title = 'prefeitura',
			gtype = 'publico'
		},
		'prefeitura.permissao',
	},

	['prefeito'] = {
		_config = {
			title = 'Prefeito(a)',
			gtype = 'primario'
		},
		'prefeito.permissao',
	},
	['colaborador'] = {
		_config = {
			title = 'Colaborador(a)',
			gtype = 'primario'
		},
		'colaborador.permissao',
	},

	--[	Departamento de Justiça ]------------------------------------------------
	
	['justica'] = {
		_config = {
			title = 'justica',
			gtype = 'publico'
		},
		'justica.permissao',
	},
	
	['juiz'] = {
		_config = {
			title = 'Juiz(a)',
			gtype = 'primario'
		},
		'juiz.permissao',
	},
	['procurador'] = {
		_config = {
			title = 'Procurador(a)',
			gtype = 'primario'
		},
		'procurador.permissao',
	},
	['promotor'] = {
		_config = {
			title = 'Promotor(a)',
			gtype = 'primario'
		},
		'promotor.permissao',
	},
	['defensor'] = {
		_config = {
			title = 'Defensor(a) Público',
			gtype = 'primario'
		},
		'defensor.permissao',
	},
	['advogado'] = {
		_config = {
			title = 'Advogado(a)',
			gtype = 'adv'
		},
		'advogado.permissao'
	},

	--[	Departamento de Justiça ][ Secundário ]----------------------------------
	
	['defensor-secundario'] = {
		_config = {
			title = 'Defensor(a) Público',
			gtype = 'secundario'
		},
		'defensor.permissao',
	},

	--[	Departamento de Policia ]------------------------------------------------
	
	['policia'] = {
		_config = {
			title = 'POLICIA',
			gtype = 'primario'
		},
		'policia.permissao',
	},
	['paisana-policia'] = {
		_config = {
			title = 'A PAISANA POLICIA',
			gtype = 'primario'
		},
		'paisana-policia.permissao',
	},

	['policia-patrulha'] = {
		_config = {
			title = 'EM PATRULHA',
			gtype = 'patrulha'
		},
		'policia-patrulha.permissao',
	},

	--[	Departamento de Policia ]------------------------------------------------

	['chefe-policia'] = {
		_config = {
			title = 'Chefe de Polícia',
			gtype = 'hie'
		},
		'chefe-policia.permissao'
	},
	['sub-chefe-policia'] = {
		_config = {
			title = 'Sub Chefe de Polícia',
			gtype = 'hie'
		},
		'sub-chefe-policia.permissao'
	},
	['inspetor'] = {
		_config = {
			title = 'Inspetor de Polícia',
			gtype = 'hie'
		},
		'inspetor.permissao'
	},
	['capitao'] = {
		_config = {
			title = 'Capitão de Polícia',
			gtype = 'hie'
		},
		'capitao.permissao'
	},
	['tenente'] = {
		_config = {
			title = 'Tenente de Polícia',
			gtype = 'hie'
		},
		'tenente.permissao'
	},
	['sub-tenente'] = {
		_config = {
			title = 'Sub Tenente de Polícia',
			gtype = 'hie'
		},
		'sub-tenente.permissao'
	},
	['primeiro-sargento'] = {
		_config = {
			title = '1º Sargento de Polícia',
			gtype = 'hie'
		},
		'primeiro-sargento.permissao'
	},
	['segundo-sargento'] = {
		_config = {
			title = '2º Sargento de Polícia',
			gtype = 'hie'
		},
		'segundo-sargento.permissao'
	},
	['agente-policia'] = {
		_config = {
			title = 'Agente de Polícia',
			gtype = 'hie'
		},
		'agente-policia.permissao'
	},
	['recruta-policia'] = {
		_config = {
			title = 'Recruta de Polícia',
			gtype = 'hie'
		},
		'recruta-policia.permissao'
	},
	
	--[	Departamento Médico ]----------------------------------------------------
	
	['ems'] = {
		_config = {
			title = 'EMS',
			gtype = 'primario'
		},
		'ems.permissao',
	}, 
	['paisana-ems'] = {
		_config = {
			title = 'EMS DE FOLGA',
			gtype = 'primario'
		},
		'paisana-ems.permissao'
	},

	--[	Departamento Médico ][ Secundário ]--------------------------------------
	
	['ems-secundario'] = {
		_config = {
			title = 'EMS',
			gtype = 'secundario'
		},
		'ems.permissao',
	}, 
	['paisana-ems-secundario'] = {
		_config = {
			title = 'EMS DE FOLGA',
			gtype = 'secundario'
		},
		'paisana-ems.permissao'
	},
	
	['diretor-geral'] = {
		_config = {
			title = 'Diretor Geral',
			gtype = 'hie'
		},
		'diretor-geral.permissao'
	},
	['diretor-auxiliar'] = {
		_config = {
			title = 'Diretor Auxiliar',
			gtype = 'hie'
		},
		'diretor-auxiliar.permissao'
	},
	['medico-chefe'] = {
		_config = {
			title = 'Médico Chefe',
			gtype = 'hie'
		},
		'medico-chefe.permissao'
	},
	['medico-cirurgiao'] = {
		_config = {
			title = 'Médico Cirurgião',
			gtype = 'hie'
		},
		'medico-cirurgiao.permissao'
	},
	['medico-aulixiar'] = {
		_config = {
			title = 'Médico Auxiliar',
			gtype = 'hie'
		},
		'medico-aulixiar.permissao'
	},
	['medico'] = {
		_config = {
			title = 'Médico',
			gtype = 'hie'
		},
		'medico.permissao'
	},
	['paramedico'] = {
		_config = {
			title = 'Paramédico',
			gtype = 'hie'
		},
		'paramedico.permissao'
	},
	['residente'] = {
		_config = {
			title = 'Residente',
			gtype = 'hie'
		},
		'residente.permissao'
	},
	['socorrista'] = {
		_config = {
			title = 'Socorrista',
			gtype = 'hie'
		},
		'socorrista.permissao'
	},
	['estagiario'] = {
		_config = {
			title = 'Estágiario',
			gtype = 'hie'
		},
		'estagiario.permissao'
	},

	--[	Imobiliaria ]------------------------------------------------------------
	
	['lider-corretor'] = {
		_config = {
			title = 'Corretor Chefe',
			gtype = 'hie'
		},
		'lider-corretor.permissao'
	},
	['corretor'] = {
		_config = {
			title = 'Corretor',
			gtype = 'primario'
		},
		'corretor.permissao'
	},
	['visitante'] = {
		_config = {
			title = 'Visitante',
			gtype = 'imobiliaria'
		},
		'visitante.permissao'
	},

	--[	Taxista ]----------------------------------------------------------------

	['lider-taxista'] = {
		_config = {
			title = 'Líder Taxista',
			gtype = 'hie'
		},
		'lider-taxista.permissao'
	},
	['taxista'] = {
		_config = {
			title = 'Taxista',
			gtype = 'primario'
		},
		'taxista.permissao'
	},
	['paisana-taxista'] = {
		_config = {
			title = 'Taxista de folga',
			gtype = 'primario'
		},
		'paisana-taxista.permissao'
	},
	
	--[	Mecânico ]---------------------------------------------------------------
	
	['lider-mecanico'] = {
		_config = {
			title = 'Líder LS Customs',
			gtype = 'hie'
		},
		'lider-mecanico.permissao'
	},
	['mecanico'] = {
		_config = {
			title = 'LS Customs',
			gtype = 'primario'
		},
		'mecanico.permissao'
	},
	['paisana-mecanico'] = {
		_config = {
			title = 'Mecânico de folga',
			gtype = 'primario'
		},
		'paisana-mecanico.permissao'
	},

	--[	Hotel ]------------------------------------------------------------------
	
	['hotel'] = {
		_config = {
			title = 'Hotel',
			gtype = 'primario'
		},
		'hotel.permissao'
	},
	
	--[	Bennys ]-----------------------------------------------------------------

	['bennys'] = {
		_config = {
			title = 'Membro da Bennys',
			gtype = 'primario'
		},
		'bennys.permissao'
	},
	['lider-bennys'] = {
		_config = {
			title = 'Líder da Bennys',
			gtype = 'hie'
		},
		'lider-bennys.permissao'
	},
	
	--[	Organização de produção e venda de drogas ][ Cocaina ]-------------------

	['orgdone'] = {
		_config = {
			title = 'Membro dos NOME',
			gtype = 'primario'
		},
		'orgdone.permissao'
	},
	['lider-orgdone'] = {
		_config = {
			title = 'Líder dos NOME',
			gtype = 'hie'
		},
		'lider-orgdone.permissao'
	},
	
	--[	Organização de produção e venda de drogas ][ Cocaina ]-------------------
	
	['orgdtwo'] = {
		_config = {
			title = 'Membro da NOME',
			gtype = 'primario'
		},
		'orgdtwo.permissao'
	},
	['lider-orgdtwo'] = {
		_config = {
			title = 'Líder da NOME',
			gtype = 'hie'
		},
		'lider-orgdtwo.permissao'
	},
	
	--[	Organização de produção e venda de drogas ][ Meta ]----------------------
	
	['orgdthree'] = {
		_config = {
			title = 'Membro da NOME',
			gtype = 'primario'
		},
		'orgdthree.permissao'
	},
	['lider-orgdthree'] = {
		_config = {
			title = 'Líder da NOME',
			gtype = 'hie'
		},
		'lider-orgdthree.permissao'
	},
	
	--[	Organização de produção e venda de drogas ][ Meta ]----------------------

	['orgdfour'] = {
		_config = {
			title = 'Membro da NOME',
			gtype = 'primario'
		},
		'orgdfour.permissao'
	},
	['lider-orgdfour'] = {
		_config = {
			title = 'Líder da NOME',
			gtype = 'hie'
		},
		'lider-orgdfour.permissao'
	},

	--[	Organização de produção e venda de drogas ][ LSD ]-----------------------

	['orgdfive'] = {
		_config = {
			title = 'Membro da NOME',
			gtype = 'primario'
		},
		'orgdfive.permissao'
	},
	['lider-orgdfive'] = {
		_config = {
			title = 'Líder da NOME',
			gtype = 'hie'
		},
		'lider-orgdfive.permissao'
	},

	--[	Organização de produção e venda de drogas ][ LSD ]-----------------------

	['orgdsix'] = {
		_config = {
			title = 'Membro da NOME',
			gtype = 'primario'
		},
		'orgdsix.permissao'
	},
	['lider-orgdsix'] = {
		_config = {
			title = 'Líder da NOME',
			gtype = 'hie'
		},
		'lider-orgdsix.permissao'
	},

	--[	Organização de produção e vendas de armas ]------------------------------

	['orggone'] = {
		_config = {
			title = 'Membro NOME',
			gtype = 'primario'
		},
		'orggone.permissao'
	},
	['lider-orggone'] = {
		_config = {
			title = 'Líder NOME',
			gtype = 'hie'
		},
		'lider-orggone.permissao'
	},
	
	--[	Organização de produção e vendas de armas ]------------------------------
	
	['orggtwo'] = {
		_config = {
			title = 'Membro NOME',
			gtype = 'primario'
		},
		'orggtwo.permissao'
	},
	['lider-orggtwo'] = {
		_config = {
			title = 'Presidente NOME',
			gtype = 'hie'
		},
		'lider-orggtwo.permissao'
	},
	
	--[	Organização de lavagem de dinheiro ]-------------------------------------
	
	['orgmone'] = {
		_config = {
			title = 'Membro Green Valley', -- Galaxy
			gtype = 'primario'
		},
		'orgmone.permissao'
	},
	['lider-orgmone'] = {
		_config = {
			title = 'Líder Green Valley',
			gtype = 'hie'
		},
		'lider-orgmone.permissao'
	},

	--[	Organização de lavagem de dinheiro ]-------------------------------------
	
	['orgmtwo'] = {
		_config = {
			title = 'Membro Gypsies', -- Tequi-La-La
			gtype = 'primario'
		},
		'orgmtwo.permissao'
	},
	['lider-orgmtwo'] = {
		_config = {
			title = 'Líder Gypsies',
			gtype = 'hie'
		},
		'lider-orgmtwo.permissao'
	},

	--[	Organização de lavagem de dinheiro ]-------------------------------------
	
	['orgmthree'] = {
		_config = {
			title = 'Membro Vanilla', -- Vanilla
			gtype = 'primario'
		},
		'orgmthree.permissao'
	},
	['lider-orgmthree'] = {
		_config = {
			title = 'Líder Vanilla',
			gtype = 'hie'
		},
		'lider-orgmthree.permissao'
	},

	--[	Organização de Produção de coletes e acessórios ]------------------------

	['orgcone'] = {
		_config = {
			title = 'Membro NOME',
			gtype = 'primario'
		},
		'orgcone.permissao'
	},
	['lider-orgcone'] = {
		_config = {
			title = 'Líder NOME',
			gtype = 'hie'
		},
		'lider-orgcone.permissao'
	},

	--[	Organização de Produção de coletes e acessórios ]------------------------
	
	['orgctwo'] = {
		_config = {
			title = 'Membro NOME',
			gtype = 'primario'
		},
		'orgctwo.permissao'
	},
	['lider-orgctwo'] = {
		_config = {
			title = 'Líder NOME',
			gtype = 'hie'
		},
		'lider-orgctwo.permissao'
	},

	--[	Staff ]------------------------------------------------------------------

	['manager'] = {
		_config = {
			title = 'Manager',
			gtype = 'staff'
		},
		
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"mqcu.permissao",
		'manager.permissao'
	},
	['off-manager'] = {
		_config = {
			title = 'Manager',
			gtype = 'staff'
		},
		
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"mqcu.permissao",
		'off-manager.permissao'
	},

	['administrador'] = {
		_config = {
			title = 'Administrador(a)',
			gtype = 'staff'
		},
		
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"mqcu.permissao",
		'administrador.permissao'
	},
	
	['off-administrador'] = {
		_config = {
			title = 'Administrador(a)',
			gtype = 'staff'
		},
		
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"mqcu.permissao",
		'off-administrador.permissao'
	},

	['moderador'] = {
		_config = {
			title = 'Moderador(a)',
			gtype = 'staff'
		},
		
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		'moderador.permissao'
	},
	['off-moderador'] = {
		_config = {
			title = 'Moderador(a)',
			gtype = 'staff'
		},
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		'off-moderador.permissao'
	},

	['suporte'] = {
		_config = {
			title = 'Suporte',
			gtype = 'staff'
		},
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		'suporte.permissao'
	},
	['off-suporte'] = {
		_config = {
			title = 'Suporte',
			gtype = 'staff'
		},
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		'off-suporte.permissao'
	},

	['aprovador-wl'] = {
		_config = {
			title = 'Aprovador WL',
			gtype = 'staff'
		},
		'aprovador-wl.permissao'
	},

	--[	Pass ]-------------------------------------------------------------------

	['ultimate'] = {
		_config = {
			title = 'Ultimate Pass',
			gtype = 'pass'
		},
		'ultimate.permissao'
	},
	['platinum'] = {
		_config = {
			title = 'Platinum Pass',
			gtype = 'pass'
		},
		'platinum.permissao'
	},
	['gold'] = {
		_config = {
			title = 'Gold Pass',
			gtype = 'pass'
		},
		'gold.permissao'
	},
	['standard'] = {
		_config = {
			title = 'Standard Pass',
			gtype = 'pass'
		},
		'standard.permissao'
	},
	['booster'] = {
		_config = {
			title = 'Booster Pass',
			gtype = 'booster'
		},
		'booster.permissao'
	}
}

cfg.users = {
	[1] = { 'manager' }
}

cfg.selectors = {}

return cfg