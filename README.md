# Курсова робота:

**Виконала:** Студентка групи ПМ-42 Гусак Анна  
**Варіант:** 3 Конференції

## Опис проекту
Цей проект реалізує повний цикл розробки Business Intelligence рішення: від проектування бази даних до створення аналітичних звітів. Система дозволяє аналізувати популярність конференцій, завантаженість спікерів та ефективність використання обладнання.

## Структура репозиторію
* **Database/** — SQL-скрипти
* **DataGeneration/** — Скрипти для генерації тестових даних
* **SSIS_Projects/** — ETL-пакети
* **SSAS_Projects/** — OLAP-куб
* **SSRS_Projects/** — Аналітичні звіти
* **Documentation/** — Звіт (PDF)

## Технологічний стек
* Microsoft SQL Server 2019/2022
* SQL Server Integration Services (SSIS)
* SQL Server Analysis Services (SSAS)
* SQL Server Reporting Services (SSRS)
* Visual Studio 2019/2022
* SQL Data Generator 4

## Реалізовані звіти
1. **Список учасників** (Table Report) 
2. **Потреба в обладнанні** (Matrix Report) 
3. **Статистика наукових ступенів** (Chart Report) 
4. **Аналіз популярності тематик** (KPI Dashboard)
5. **Розклад конференцій** (Drill-down)