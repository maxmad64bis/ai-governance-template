# Claude Code — DO & DON'T (V1.1)

Ce document synthétise les pratiques qui reviennent de manière cohérente dans les discussions, la documentation officielle et les retours expérimentés, en éliminant les hypothèses fragiles ou contradictoires.

## Objectif

Maximiser la qualité des résultats tout en limitant :

* le bruit dans le contexte ;
* les coûts inutiles ;
* la dérive des instructions ;
* la complexité du système.

---

# Principes directeurs

## Signal > Volume

Chaque élément ajouté au système doit apporter davantage de valeur qu'il ne consomme de contexte.

Une règle courte et utile vaut mieux qu'une page de bonnes intentions.

---

## Just-In-Time Context

Charger l'information lorsqu'elle devient nécessaire.

Ne pas charger de documentation, règles ou connaissances « au cas où ».

---

## Mémoire en couches

Séparer systématiquement :

### Permanent

Connaissances stables :

* architecture ;
* conventions ;
* règles métier ;
* contraintes de sécurité.

### Projet

Connaissances spécialisées :

* documentation technique ;
* guides ;
* procédures.

### Temporaire

État courant :

* tâches ;
* handoff ;
* prochaines étapes ;
* décisions récentes.

Ne jamais mélanger ces trois niveaux.

---

# DO

## Gestion du contexte

### DO — Garder un contexte minimal

Conserver uniquement les informations nécessaires à la tâche en cours.

---

### DO — Utiliser `/clear` lorsque le contexte dérive

Réinitialiser lorsqu'on observe :

* répétitions ;
* oublis ;
* confusion ;
* réponses inutilement longues.

---

### DO — Résumer l'état, pas l'historique

Conserver :

* objectifs ;
* décisions ;
* contraintes ;
* prochaines actions.

Éliminer :

* discussions anciennes ;
* raisonnements intermédiaires ;
* historique complet.

---

## Organisation des instructions

### DO — Garder CLAUDE.md court

Y placer uniquement :

* conventions ;
* architecture résumée ;
* contraintes critiques ;
* commandes essentielles ;
* pièges récurrents.

---

### DO — Faire de CLAUDE.md un briefing

Le fichier doit permettre à un nouvel intervenant de comprendre rapidement :

* comment le projet fonctionne ;
* ce qu'il ne faut pas casser ;
* comment travailler correctement.

---

### DO — Utiliser la divulgation progressive

Préférer :

```text
CLAUDE.md
├─ principes
├─ conventions
└─ références
```

et déplacer les détails dans :

```text
docs/
guides/
rules/
agents/
```

---

### DO — Séparer les connaissances par domaine

Préférer :

```text
architecture.md
testing.md
deployment.md
security.md
```

à :

```text
documentation.md
```

de 1000 lignes.

---

### DO — Stocker uniquement les informations stables

Ajouter au contexte permanent uniquement ce qui :

* reste valable plusieurs mois ;
* est utile à de nombreuses tâches ;
* provoque régulièrement des erreurs lorsqu'il manque.

---

## Utilisation des subagents

### DO — Utiliser des subagents pour isoler du bruit

Bons cas :

* audits ;
* recherche ;
* analyse ;
* exploration de code ;
* traitement parallèle.

---

### DO — Utiliser des subagents pour paralléliser

Exemples :

* backend ;
* frontend ;
* documentation ;
* sécurité.

---

### DO — Fournir un périmètre précis

Toujours définir :

* objectif ;
* fichiers concernés ;
* résultat attendu ;
* critères de validation.

---

### DO — Considérer les subagents comme coûteux

Chaque subagent doit produire davantage de valeur que le coût de son orchestration.

---

## Gestion multi-comptes

### DO — Mutualiser le comportement

Partager :

* agents ;
* règles ;
* templates ;
* settings ;
* workflows.

---

### DO — Séparer l'identité

Isoler :

* authentification ;
* tokens ;
* secrets ;
* sessions.

---

### DO — Utiliser une source de vérité unique

Éviter plusieurs copies concurrentes des mêmes règles.

---

## Optimisation

### DO — Charger uniquement ce qui est nécessaire

Avant d'ajouter une règle :

Demander :

> Cette information sera-t-elle utile régulièrement ?

Si non :

* document spécialisé ;
* chargement à la demande.

---

### DO — Réviser régulièrement les instructions

Supprimer :

* règles obsolètes ;
* doublons ;
* exceptions devenues inutiles.

Le système doit devenir plus simple avec le temps, pas plus complexe.

---

## Sécurité

### DO — Isoler les credentials

Toujours séparer :

* configuration partagée ;
* données sensibles ;
* authentification.

---

### DO — Auditer avant d'automatiser

Classifier chaque élément :

* partageable ;
* spécifique ;
* sensible.

Puis automatiser.

---

# DON'T

## Contexte

### DON'T — Transformer une session en mémoire permanente

Éviter :

* sessions de plusieurs jours ;
* accumulation de sujets ;
* contexte gigantesque.

---

### DON'T — Réinjecter l'historique complet

Mauvais :

```text
Résumé = conversation complète
```

Bon :

```text
Résumé = état actuel
```

---

## CLAUDE.md

### DON'T — Transformer CLAUDE.md en wiki

Ne pas y mettre :

* documentation complète ;
* procédures détaillées ;
* tutoriels ;
* changelog ;
* tickets.

---

### DON'T — Répéter ce que le code montre déjà

Éviter :

* descriptions évidentes ;
* informations visibles dans l'arborescence ;
* conventions déjà exprimées par le code.

---

### DON'T — Empiler des règles génériques

Éviter :

* « écris du bon code »
* « suis les bonnes pratiques »
* « sois professionnel »

Les règles doivent être concrètes et vérifiables.

---

### DON'T — Dupliquer les mêmes règles partout

Éviter les copies de :

* conventions ;
* workflows ;
* contraintes.

Une règle doit avoir un propriétaire clair.

---

## Subagents

### DON'T — Utiliser un subagent pour une micro-tâche

Exemples :

* lire un fichier ;
* renommer une variable ;
* exécuter une commande ;
* répondre à une question simple.

---

### DON'T — Déléguer sans périmètre

Éviter :

```text
Analyse le projet.
```

Préférer :

```text
Analyse uniquement le système d'authentification.
```

---

## Architecture

### DON'T — Tout mettre dans le contexte global

Éviter :

```text
CLAUDE.md
1500 lignes
```

même si chaque partie semble utile individuellement.

---

### DON'T — Charger de la documentation « au cas où »

Le contexte doit être :

* pertinent ;
* nécessaire ;
* actuel.

Pas préventif.

---

### DON'T — Stocker des tâches temporaires dans la mémoire permanente

Ne jamais ajouter dans CLAUDE.md :

```text
Corriger bug X
Finir ticket Y
Migrer module Z
```

---

## Sécurité

### DON'T — Partager les credentials

Ne jamais partager :

* tokens ;
* secrets ;
* authentifications ;
* sessions.

Partager uniquement le comportement.

---

# Checklist avant toute modification

Avant d'ajouter une règle, un agent, un hook ou une instruction :

### 1

Est-elle stable pendant plusieurs semaines ou mois ?

### 2

Est-elle utile à plusieurs tâches ?

### 3

Son absence provoque-t-elle régulièrement des erreurs ?

### 4

Peut-elle être déduite du code ou d'une documentation existante ?

### 5

Existe-t-elle déjà ailleurs ?

### 6

Ajoute-t-elle plus de signal que de bruit ?

Si une réponse est problématique, ne pas l'ajouter sans justification explicite.

---

# Règle d'or

> Conserver durablement uniquement les connaissances stables et à forte valeur ; charger tout le reste lorsqu'il devient nécessaire.
